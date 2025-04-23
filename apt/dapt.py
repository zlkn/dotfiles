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
        installed = {}
        cache = AptWrapper.refresh()

        for pkg in cache:
            if pkg.is_installed:
                installed[pkg.name] = pkg.installed.version
        return installed


class DApt:
    def __init__(self):
        pass

    def init(self):
        pass

    def plan(self, config):
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

    dapt = DApt()

    if args.command == "init":
        dapt.init()
    elif args.command == "plan":
        dapt.plan(args.config)
    elif args.command == "apply":
        dapt.apply()


if __name__ == "__main__":
    main()
