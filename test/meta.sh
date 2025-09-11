#!/usr/bin/env bash
set -euo pipefail

# === Config (edit as you like) ===
PKG_NAME="${1:-dev-tools-meta}"           # package name (default if not passed)
VERSION="${2:-1.0.0}"                     # package version (default if not passed)
MAINTAINER="${MAINTAINER:-$(whoami) <root@localhost>}"
ARCH="all"
# Use Debian-style alternatives to tolerate naming differences:
# (User asked for "neowofetch"; Debian has "neofetch".)
DEPENDS="fzf, rsync, ncdu, htop, stow, neofetch | neowofetch"
DESCRIPTION="Meta package that depends on fzf, rsync, ncdu, htop, stow, and neofetch."
SECTION="metapackages"
PRIORITY="optional"
# ================================

WORKDIR="$(mktemp -d)"
PKGDIR="$WORKDIR/${PKG_NAME}_${VERSION}"
DEBIANDIR="$PKGDIR/DEBIAN"
mkdir -p "$DEBIANDIR"

cat > "$DEBIANDIR/control" <<EOF
Package: ${PKG_NAME}
Version: ${VERSION}
Section: ${SECTION}
Priority: ${PRIORITY}
Architecture: ${ARCH}
Maintainer: ${MAINTAINER}
Depends: ${DEPENDS}
Description: ${DESCRIPTION}
 This package contains no files; installing it ensures the listed tools are installed.
EOF

# Ensure perms are correct for control files
find "$PKGDIR/DEBIAN" -type f -exec chmod 0644 {} \;
chmod 0755 "$PKGDIR/DEBIAN"

OUT_DEB="${PKG_NAME}_${VERSION}_${ARCH}.deb"
dpkg-deb --build --root-owner-group "$PKGDIR" "$OUT_DEB" >/dev/null

echo "Built: $OUT_DEB"
echo "Install with: sudo apt install ./$(basename "$OUT_DEB")"

# Clean up the temp tree but leave the .deb in CWD
rm -rf "$WORKDIR"

