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


    def get_apt_state(self):
        state = {
            "declarative": {},
            "manual":     {},
            "auto":       {}
        }

        state = AptWrapper.get_installed_packages()
        state["declarative"] = {}
        return state


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


    def plan(self):
        pass

    def apply(self):
        pass

def main():
    parser = argparse.ArgumentParser(
        description="Declarative Debian apt package manager using an AptWrapper with python-apt API"
    )
    parser.add_argument("command", choices=["init", "plan", "apply"],
                        help="Command to execute: init, plan, or apply")
    parser.add_argument("--config", default="decapt.conf",
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
