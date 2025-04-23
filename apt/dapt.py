#!/usr/bin/env python3

import os
import sys
import argparse
import json

import apt
import apt.progress.text

class AptWrapper:
    @staticmethod
    def refresh():
        return apt.Cache()

    @staticmethod
    def get_installed_packages():
        packages = {"manual": {}, "auto": {}}
        cache = AptWrapper.refresh()

        for pkg in cache:
            if pkg.is_installed:
                version = pkg.installed.version
                if pkg.is_auto_installed:
                    packages["auto"][pkg.name] = version
                else:
                    packages["manual"][pkg.name] = version

        return packages


class DApt:
    def __init__(self, config):
        self.state_dir = os.path.expanduser("~/.local/state/decapt")
        self.state = os.path.join(self.state_dir, "state.json")
        self.plan_file = os.path.join(self.state_dir, "plan.json")
        self.config = config


    def read_state_file(self):
        if os.path.exists(self.state):
            try:
                with open(self.state, "r") as f:
                    return json.load(f)
            except json.JSONDecodeError as err:
                print(f"Error parsing state file: {err}", file=sys.stderr)
                sys.exit(1)
        else:
            print("Error: No state file found. Please run the 'init' command first.", file=sys.stderr)
            sys.exit(1)

    def get_apt_state(self):
        state = {
            "declarative": {},
            "manual":     {},
            "auto":       {}
        }
        state.update(AptWrapper.get_installed_packages())

        return state

    def read_user_config(self):
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
            with open(self.config, "r") as f:
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

    def init(self):
        if os.path.exists(self.state):
            print(f"State file already exists at {self.state}")
            sys.exit(0)

        os.makedirs(self.state_dir, exist_ok=True)

        state = self.get_apt_state()

        try:
            with open(self.state, "w") as f:
                json.dump(state, f, indent=2)

            print(f"Declarative/Manual/Auto package state has been written to {self.state}")
            print("Additional info:")
            print(f"  Declarative packages count: {len(state["declarative"])}")
            print(f"  Manual packages count: {len(state["manual"])}")
            print(f"  Auto packages count: {len(state["auto"])}")

        except Exception as err:
            print(f"Error writing state file: {err}", file=sys.stderr)
            sys.exit(1)


    def diff(self, current_state, desired_state):
        pass


    def plan(self):
        user_state = self.read_user_config()
        print(f"user config: {user_state}")
        # system_state = self.get_apt_state()
        # current_state = self.read_state_file()
        #
        # self.diff(system_state, current_state)

    def apply(self):
        pass

def main():
    parser = argparse.ArgumentParser(
        description="Declarative Debian apt package manager using an AptWrapper with python-apt API"
    )
    parser.add_argument("command", choices=["init", "plan", "apply"],
                        help="Command to execute: init, plan, or apply")
    parser.add_argument("--config", default="dapt.conf",
                        help="Path to configuration file (default: decapt.conf)")
    args = parser.parse_args()

    dapt = DApt(args.config)

    if args.command == "init":
        dapt.init()
    elif args.command == "plan":
        dapt.plan()
    elif args.command == "apply":
        dapt.apply()


if __name__ == "__main__":
    main()
