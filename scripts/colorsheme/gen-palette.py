#!/usr/bin/env python3

import sys

import apps
from palettes import VARIANTS


def main():
    for variant, palette in VARIANTS.items():
        apps.generate(variant, palette)


if __name__ == "__main__":
    sys.exit(main())
