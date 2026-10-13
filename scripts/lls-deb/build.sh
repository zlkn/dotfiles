#!/bin/bash
set -euo pipefail

NAME="lua-language-server"
REPO="LuaLS/lua-language-server"
OUT_DIR="$(cd "$(dirname "$0")" && pwd)/dist"

VERSION="${1:-$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" | sed -n 's/.*"tag_name": *"\([^"]*\)".*/\1/p')}"
VERSION="${VERSION#v}"
echo "Version: $VERSION"

ARCH="$(dpkg --print-architecture)"
case "$ARCH" in
    amd64) PLATFORM="linux-x64" ;;
    arm64) PLATFORM="linux-arm64" ;;
    *) echo "Unsupported architecture: $ARCH" >&2; exit 1 ;;
esac

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

PKG="$WORK/pkg"
mkdir -p "$PKG/usr/lib/$NAME" "$PKG/usr/bin" "$PKG/DEBIAN"

curl -fsSL "https://github.com/$REPO/releases/download/$VERSION/$NAME-$VERSION-$PLATFORM.tar.gz" \
    | tar xz -C "$PKG/usr/lib/$NAME"

cat > "$PKG/usr/bin/$NAME" <<'EOF'
#!/bin/sh
STATE="${XDG_CACHE_HOME:-$HOME/.cache}/lua-language-server"
exec /usr/lib/lua-language-server/bin/lua-language-server \
    --logpath="$STATE/log" --metapath="$STATE/meta" "$@"
EOF
chmod 755 "$PKG/usr/bin/$NAME"

cat > "$PKG/DEBIAN/control" <<EOF
Package: $NAME
Version: $VERSION
Architecture: $ARCH
Maintainer: $(git config user.name) <$(git config user.email)>
Depends: libc6
Section: devel
Priority: optional
Homepage: https://github.com/$REPO
Description: Lua language server
 Repackaged upstream release of LuaLS lua-language-server.
EOF

mkdir -p "$OUT_DIR"
dpkg-deb --root-owner-group --build "$PKG" "$OUT_DIR/${NAME}_${VERSION}_${ARCH}.deb"
