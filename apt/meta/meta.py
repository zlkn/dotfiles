#!/usr/bin/env python3

import os
import subprocess
from pathlib import Path

PACKAGE_NAME = "user-packages"
VERSION = "1.0"
ARCH = "all"
MAINTAINER = "Your Name <you@example.com>"
DESCRIPTION = "Meta-package to install user-defined packages."
CONFIG_FILE = "packages.conf"
BUILD_DIR = Path(PACKAGE_NAME)


def parse_package_config(filename):
    """
    Simplified YAML parser for config format:
    section:
      - pkg1
      - pkg2
    """
    packages = []
    try:
        with open(filename, "r") as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith("#") or line.startswith("---"):
                    continue
                if line.endswith(":"):
                    continue
                elif line.startswith("-"):
                    item = line.lstrip("-").strip()
                    if item:
                        packages.append(item)
        return sorted(set(packages))
    except Exception as err:
        print(f"Error reading config: {err}")
        exit(1)


def create_debian_structure(packages):
    if BUILD_DIR.exists():
        subprocess.run(["rm", "-rf", str(BUILD_DIR)], check=True)

    BUILD_DIR.mkdir()
    os.chdir(BUILD_DIR)

    # os.makedirs("DEBIAN", exist_ok=True)
    Path("DEBIAN").mkdir(exist_ok=True)

    # Write debian/control
    deps = ", ".join(packages)
    control_path = Path("DEBIAN/control")
    control = control = f"""Package: {PACKAGE_NAME}
Version: {VERSION}
Section: utils
Priority: optional
Architecture: {ARCH}
Maintainer: {MAINTAINER}
Depends: {deps}
Description: {DESCRIPTION}
 This package pulls a set of user-specified tools and packages.
"""
    control_path.write_text(control)

    # Cleanup unnecessary template files
    for ext in [".ex", ".EX", ".install"]:
        for f in Path("DEBIAN").glob(f"*{ext}"):
            f.unlink(missing_ok=True)

    # Write debian/rules
    Path("DEBIAN/rules").write_text("#!/usr/bin/make -f\n%:\n\tdh $@\n")
    Path("DEBIAN/rules").chmod(0o755)


def build_package():
    print("📦 Running: dpkg-deb --build user-packages user-packages.deb")
    print(f"📂 Current working directory: {os.getcwd()}")
    try:
        result = subprocess.run(
            ["dpkg-deb", "--build", ".", "../meta.deb"],
            check=True,
            text=True,
            capture_output=True,
        )
        print("\n✅ Build complete! Your package is in the parent directory.")
    except subprocess.CalledProcessError as e:
        print("Build failed:")
        print(e.stderr.strip())
        exit(1)


def main():
    packages = parse_package_config(CONFIG_FILE)
    print(f"✔️ Parsed {len(packages)} packages from {CONFIG_FILE}")
    create_debian_structure(packages)
    build_package()


if __name__ == "__main__":
    main()
