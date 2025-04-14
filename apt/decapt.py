#!/usr/bin/env python3
"""
decapt.py - Declarative apt package manager using python-apt API

This script manages Debian apt packages in a declarative style with three commands:

  init   - Writes the current manual/auto installed package state to a file (JSON).
  plan   - Compares the current APT cache against a configuration file,
           computes a diff (install, remove, update actions), and writes a plan (JSON).
  apply  - Uses the python-apt API to apply the planned changes (install, remove, update).

Usage:
  ./decapt.py init
  ./decapt.py plan [--config decapt.conf]
  ./decapt.py apply

The configuration file uses a simplified, YAML-like format, for example:

    ---
    common:
      - ncdu
      - nslookup

    devops:
      - terraform
      - docker-ce
      - util-linux/now==2.40.4-5

State and plan files are stored under:
  $HOME/.local/state/decapt/
"""

import os
import sys
import argparse
import json

import apt
import apt.progress.text

STATE_DIR = os.path.expanduser("~/.local/state/decapt")
STATE_FILE = os.path.join(STATE_DIR, "state.json")
PLAN_FILE = os.path.join(STATE_DIR, "plan.json")


def ensure_state_dir():
    """Ensure that the directory for state and plan files exists."""
    if not os.path.exists(STATE_DIR):
        os.makedirs(STATE_DIR, exist_ok=True)


def init_state():
    """
    Build state info using python-apt.
    Iterate over the APT cache and, for installed packages,
    separate those marked as automatically installed from those manually installed.
    Returns a dict with keys 'manual' and 'auto' listing package names.
    """
    cache = apt.Cache()
    manual = []
    auto = []
    # Iterate over all packages in the cache.
    for pkg in cache:
        if pkg.is_installed:
            if pkg.is_auto_installed:
                auto.append(pkg.name)
            else:
                manual.append(pkg.name)
    return {"manual": manual, "auto": auto}


def cmd_init():
    """
    INIT command:
      Save the current manual/auto package state (using python-apt API) to the state file (JSON).
    """
    state = init_state()
    ensure_state_dir()
    try:
        with open(STATE_FILE, "w") as f:
            json.dump(state, f, indent=2)
    except Exception as err:
        print(f"Error writing state file: {err}", file=sys.stderr)
        sys.exit(1)
    print(f"Manual/Auto package state has been written to {STATE_FILE}")
    print("Additional info:")
    print(f"  Manual packages count: {len(state['manual'])}")
    print(f"  Auto packages count: {len(state['auto'])}")


def read_state():
    """
    Read the stored state (manual/auto lists) from the state file.
    Returns the parsed dict or exits if not found.
    """
    if os.path.exists(STATE_FILE):
        try:
            with open(STATE_FILE, "r") as f:
                return json.load(f)
        except json.JSONDecodeError as err:
            print(f"Error parsing state file: {err}", file=sys.stderr)
            sys.exit(1)
    else:
        print("Error: No state file found. Please run the 'init' command first.", file=sys.stderr)
        sys.exit(1)


def parse_config_file(config_path):
    """
    Parse a configuration file using a simple custom parser.
    Expected format (leading '---' is optional):

    ---
    common:
      - ncdu
      - nslookup

    devops:
      - terraform
      - docker-ce
      - util-linux/now==2.40.4-5

    Returns a dict mapping section names to lists of package specifications.
    """
    config = {}
    current_section = None
    try:
        with open(config_path, "r") as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith("#"):
                    continue  # Skip empty lines and comments.
                if line.startswith("---"):
                    continue  # Ignore YAML document separator.
                if line.endswith(":"):
                    # Section header.
                    current_section = line[:-1].strip()
                    config[current_section] = []
                elif line.startswith("-"):
                    # List item.
                    if current_section is None:
                        print("Error: List item found outside of any section.", file=sys.stderr)
                        sys.exit(1)
                    item = line.lstrip("-").strip()
                    if item:
                        config[current_section].append(item)
                else:
                    # Ignore unexpected lines.
                    continue
    except Exception as err:
        print(f"Error reading config file: {err}", file=sys.stderr)
        sys.exit(1)
    return config


def parse_pkg_spec(spec):
    """
    Parse a package specification string.

    The spec may be:
       - "pkgname"
       - "pkgname==version"
       - "pkgname/anything==version" (the package name is taken as the part before the slash)

    Returns:
         tuple: (package, version) where version is None if not specified.
    """
    desired_version = None
    if "==" in spec:
        pkg_part, desired_version = spec.split("==", 1)
    else:
        pkg_part = spec

    if "/" in pkg_part:
        pkg = pkg_part.split("/")[0]
    else:
        pkg = pkg_part

    return pkg, desired_version


def build_installed_dict():
    """
    Build a dictionary of installed packages using python-apt.
    Returns: {package_name: installed_version}
    """
    cache = apt.Cache()
    installed = {}
    for pkg in cache:
        if pkg.is_installed:
            installed[pkg.name] = pkg.installed.version
    return installed


def cmd_plan(config_file):
    """
    PLAN command:
      - Retrieve live installed package info (name and version) via python-apt.
      - Ensure the state file (from init) exists (for informational purposes).
      - Read the desired package list from the configuration file.
      - Build a plan:
           * For each desired package not installed -> install.
           * For installed packages with a version mismatch -> update.
           * For installed packages not listed in the desired config -> remove.
      - Write the plan as a JSON file and print it.
    """
    installed = build_installed_dict()

    # Just verify the state file exists (its info is informational only).
    read_state()

    if not os.path.exists(config_file):
        print(f"Error: Configuration file {config_file} not found.", file=sys.stderr)
        sys.exit(1)
    config = parse_config_file(config_file)

    # Combine all desired packages from all sections into a single dict.
    desired = {}  # key: package name, value: desired version (or None)
    for section, pkg_list in config.items():
        for spec in pkg_list:
            pkg, ver = parse_pkg_spec(spec)
            desired[pkg] = ver

    plan = {"install": [], "remove": [], "update": []}

    # For each desired package, if not installed then plan to install.
    # If installed but a desired version is specified and does not match, plan to update.
    for pkg, desired_version in desired.items():
        if pkg not in installed:
            plan["install"].append({"package": pkg, "version": desired_version})
        else:
            if desired_version is not None and installed[pkg] != desired_version:
                plan["update"].append({
                    "package": pkg,
                    "desired_version": desired_version,
                    "installed_version": installed[pkg]
                })

    # For packages that are installed but not desired, plan removal.
    for pkg in installed.keys():
        if pkg not in desired:
            plan["remove"].append(pkg)

    ensure_state_dir()
    try:
        with open(PLAN_FILE, "w") as f:
            json.dump(plan, f, indent=2)
    except Exception as err:
        print(f"Error writing plan file: {err}", file=sys.stderr)
        sys.exit(1)
    print(f"Plan written to {PLAN_FILE}\n")
    print(json.dumps(plan, indent=2))


def commit_changes(changes):
    """
    Given a list of changes (each a tuple (action, package_name, version)),
    use python-apt API to mark changes and commit them.
    action: 'install', 'remove', or 'update'
    For 'update', the desired version must be specified.
    """
    cache = apt.Cache()
    # Mark changes.
    for change in changes:
        action, pkg_name, ver = change
        if pkg_name not in cache:
            print(f"Warning: Package {pkg_name} not found in cache. Skipping.", file=sys.stderr)
            continue
        pkg = cache[pkg_name]
        if action == "remove":
            if pkg.is_installed:
                print(f"Marking {pkg_name} for removal.")
                pkg.mark_delete(auto_remove=True)
            else:
                print(f"Package {pkg_name} is not installed; skipping removal.")
        elif action in ("install", "update"):
            # For update, we force the version if specified.
            # Find a version that matches the desired version if provided.
            if ver is not None:
                candidate = None
                for candidate_ver in pkg.versions:
                    if candidate_ver.version == ver:
                        candidate = candidate_ver
                        break
                if candidate is None:
                    print(f"Warning: Desired version {ver} for package {pkg_name} not found. Skipping {action}.", file=sys.stderr)
                    continue
                # Set the candidate to desired version.
                pkg.candidate = candidate
            print(f"Marking {pkg_name} for installation/update.")
            pkg.mark_install(from_user=True)
        else:
            print(f"Unknown action {action} for package {pkg_name}.", file=sys.stderr)

    # Commit changes.
    try:
        print("Committing changes...")
        # Use a simple text progress handler.
        install_progress = apt.progress.text.InstallProgress()
        acquire_progress = apt.progress.text.AcquireProgress()
        cache.commit(install_progress, acquire_progress)
    except Exception as err:
        print(f"Error committing changes: {err}", file=sys.stderr)
        sys.exit(1)


def cmd_apply():
    """
    APPLY command:
      - Read the plan file (JSON).
      - For each action in the plan (install, update, remove), mark the change in the APT cache.
      - Commit changes using the python-apt API.
    """
    if not os.path.exists(PLAN_FILE):
        print("Error: Plan file not found. Please run the 'plan' command first.", file=sys.stderr)
        sys.exit(1)
    try:
        with open(PLAN_FILE, "r") as f:
            plan = json.load(f)
    except json.JSONDecodeError as err:
        print(f"Error parsing plan file: {err}", file=sys.stderr)
        sys.exit(1)

    changes = []
    # For removals, the plan contains package names.
    for pkg in plan.get("remove", []):
        changes.append(("remove", pkg, None))
    # For installs, the plan is a dict with package name and version.
    for entry in plan.get("install", []):
        changes.append(("install", entry["package"], entry.get("version")))
    for entry in plan.get("update", []):
        changes.append(("update", entry["package"], entry.get("desired_version")))

    if not changes:
        print("No changes to apply.")
        sys.exit(0)

    commit_changes(changes)
    print("All changes have been applied.")


def main():
    parser = argparse.ArgumentParser(
        description="Declarative Debian apt package manager using python-apt API (manual/auto state only)"
    )
    parser.add_argument("command", choices=["init", "plan", "apply"],
                        help="Command to execute: init, plan, or apply")
    parser.add_argument("--config", default="decapt.conf",
                        help="Path to configuration file (default: decapt.conf)")
    args = parser.parse_args()

    if args.command == "init":
        cmd_init()
    elif args.command == "plan":
        cmd_plan(args.config)
    elif args.command == "apply":
        cmd_apply()


if __name__ == "__main__":
    main()

