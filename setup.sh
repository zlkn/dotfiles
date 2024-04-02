#!/bin/bash

set -ex

mkdir -p $PWD/Personal || true
mkdir -p $PWD/Workspace || true
ln -sf $PWD/gitconfig $HOME/.gitconfig
ln -sf $PWD/Personal/gitconfig $HOME/Personal/.gitconfig
