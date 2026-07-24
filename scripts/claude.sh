#!/bin/bash

if ! command -v pass &>/dev/null; then
    echo "pass is not installed"
    exit 1
fi

export YOUTRACK_TOKEN=$(pass tokens/youtrack)
export ANTHROPIC_API_KEY=$(pass tokens/ANTHROPIC_API_KEY)
export GITLAB_TOKEN=$(pass tokens/glab-cli)

exec claude "$@"
