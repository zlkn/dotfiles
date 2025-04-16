#!/usr/bin/env python3
"""
decapt.py - Declarative apt package manager using python-apt API with an AptWrapper

This script manages Debian apt packages in a declarative style with three commands:

  init   - Writes the current manual/auto installed package state to a JSON file.
  plan   - Compares the current APT cache (using the wrapper) against a configuration file,
           computes a diff (install, remove, update actions), and writes a plan (JSON).
  apply  - Uses the AptWrapper methods to mark packages for installation, removal, or update,
           then commits the changes via the python-apt API.

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


class AptWrapper:
    """
    A wrapper class to encapsulate operations with the python-apt API.
    """
    def __init__(self):
        self.cache = apt.Cache()

    def refresh(self):
        """Refresh the cache if needed."""
        self.cache.open()

    def get_installed_packages(self):
        """
        Returns a dictionary mapping installed package names to their installed version.
        """
        installed = {}
        for pkg in self.cache:
            if pkg.is_installed:
                installed[pkg.name] = pkg.installed.version
        return installed

    def get_manual_auto(self):
        """
        Returns a tuple (manual, auto) listing package names.
          - manual: packages not marked as auto-installed.
          - auto: packages marked as auto-installed.
        """
        manual = []
        auto = []
        for pkg in self.cache:
            if pkg.is_installed:
                if pkg.is_auto_installed:
                    auto.append(pkg.name)
                else:
                    manual.append(pkg.name)
        return manual, auto

    def mark_for_install(self, pkg_name, version=None):
        """
        Marks a package for installation (or update). If a version is specified, tries
        to set the candidate version accordingly.
        Returns True on success, False otherwise.
        """
        if pkg_name not in self.cache:
            print(f"Warning: Package {pkg_name} not found in cache.", file=sys.stderr)
            return False
        pkg = self.cache[pkg_name]
        if version is not None:
            candidate = None
            for candidate_ver in pkg.versions:
                if candidate_ver.version == version:
                    candidate = candidate_ver
                    break
            if candidate is None:
                print(f"Warning: Desired version {version} for package {pkg_name} not found.", file=sys.stderr)
                return False
            pkg.candidate = candidate
        pkg.mark_install(from_user=True)
        return True

    def mark_for_removal(self, pkg_name):
        """
        Marks a package for removal if installed.
        Returns True on success, False otherwise.
        """
        if pkg_name not in self.cache:
            print(f"Warning: Package {pkg_name} not found in cache.", file=sys.stderr)
            return False
        pkg = self.cache[pkg_name]
        if pkg.is_installed:
            pkg.mark_delete(auto_remove=True)
        else:
            print(f"Package {pkg_name} is not installed; skipping removal.", file=sys.stderr)
        return True

    def commit(self, install_progress, acquire_progress):
        """Commits the marked changes using the provided progress handlers."""
        self.cache.commit(install_progress, acquire_progress)


def ensure_state_dir():
    """Ensure that the directory for state and plan files exists."""
    if not os.path.exists(STATE_DIR):
        os.makedirs(STATE_DIR, exist_ok=True)


def cmd_init():
    """
    INIT command:
      Uses AptWrapper to get manual and auto installed packages,
      then writes that state to the JSON state file.
    """
    apt_wrapper = AptWrapper()
    manual, auto = apt_wrapper.get_manual_auto()
    state = {"manual": manual, "auto": auto}
    ensure_state_dir()
    try:
        with open(STATE_FILE, "w") as f:
            json.dump(state, f, indent=2)
    except Exception as err:
        print(f"Error writing state file: {err}", file=sys.stderr)
        sys.exit(1)
    print(f"Manual/Auto package state has been written to {STATE_FILE}")
    print("Additional info:")
    print(f"  Manual packages count: {len(manual)}")
    print(f"  Auto packages count: {len(auto)}")


def read_state():
    """
    Reads the stored state (manual and auto lists) from the state file.
    Exits if the file is not found or cannot be parsed.
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
    Builds a dictionary of installed packages using the AptWrapper.
    Returns: {package_name: installed_version}
    """
    apt_wrapper = AptWrapper()
    return apt_wrapper.get_installed_packages()


def cmd_plan(config_file):
    """
    PLAN command:
      - Uses the AptWrapper to get live package info (name and version).
      - Verifies that the state file (from 'init') exists (for informational purposes).
      - Reads the desired package list from the configuration file.
      - Builds a plan:
           * For each desired package not installed -> install.
           * For installed packages with a version mismatch -> update.
           * For packages installed but not desired -> remove.
      - Writes the plan to a JSON file and prints it.
    """
    installed = build_installed_dict()
    # Ensure state file exists.
    read_state()

    if not os.path.exists(config_file):
        print(f"Error: Configuration file {config_file} not found.", file=sys.stderr)
        sys.exit(1)
    config = parse_config_file(config_file)

    # Combine desired packages from all sections into a single dict.
    desired = {}  # key: package name, value: desired version (or None)
    for section, pkg_list in config.items():
        for spec in pkg_list:
            pkg, ver = parse_pkg_spec(spec)
            desired[pkg] = ver

    plan = {"install": [], "remove": [], "update": []}

    # For each desired package: if not installed, plan to install;
    # if installed but version mismatch and version is specified, plan an update.
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

    # For packages installed but not desired, plan removal.
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
    uses the AptWrapper to mark changes and then commits them.
    action: 'install', 'remove', or 'update'.
    For 'update', the desired version must be specified.
    """
    apt_wrapper = AptWrapper()
    for change in changes:
        action, pkg_name, ver = change
        if action == "remove":
            apt_wrapper.mark_for_removal(pkg_name)
        elif action in ("install", "update"):
            apt_wrapper.mark_for_install(pkg_name, version=ver)
        else:
            print(f"Unknown action {action} for package {pkg_name}.", file=sys.stderr)

    try:
        print("Committing changes...")
        install_progress = apt.progress.text.InstallProgress()
        acquire_progress = apt.progress.text.AcquireProgress()
        apt_wrapper.commit(install_progress, acquire_progress)
    except Exception as err:
        print(f"Error committing changes: {err}", file=sys.stderr)
        sys.exit(1)


def cmd_apply():
    """
    APPLY command:
      - Reads the plan file (JSON).
      - For each action (install, update, remove) in the plan, calls the appropriate
        method of the AptWrapper to mark the change.
      - Commits the changes.
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
    for pkg in plan.get("remove", []):
        changes.append(("remove", pkg, None))
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
        description="Declarative Debian apt package manager using an AptWrapper with python-apt API"
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
