#!/bin/bash

export VERSION=$(curl -fsSL https://downloads.claude.ai/claude-code-releases/latest)
echo "Latest version is: $VERSION"

export PLATFORM="linux-x64"
echo "PLATFOTM=$PLATFORM"

curl -fsSL -o /tmp/claude https://downloads.claude.ai/claude-code-releases/$VERSION/$PLATFORM/claude
chmod +x /tmp/claude
/tmp/claude install
