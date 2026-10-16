#!/usr/bin/env python3

import argparse
import sys

import apca
import apps
import wcag
from palettes import VARIANTS


def main() -> None:
    parser = argparse.ArgumentParser(description="Palette tools.")
    parser.add_argument(
        "-gen",
        action="store_true",
        help="generate theme files for every app from the palettes",
    )
    parser.add_argument(
        "-wcag",
        action="store_true",
        help="check WCAG contrast of every color against the background",
    )
    parser.add_argument(
        "-apca",
        action="store_true",
        help="check APCA (WCAG 3.0 draft) contrast of every color against the background",
    )
    args = parser.parse_args()

    if not (args.gen or args.wcag or args.apca):
        parser.print_help()
        return

    for variant, palette in VARIANTS.items():
        if args.wcag:
            wcag.report(variant, palette)
        if args.apca:
            apca.report(variant, palette)
        if args.gen:
            apps.generate(variant, palette)


if __name__ == "__main__":
    sys.exit(main())
