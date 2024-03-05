#!/bin/bash

set -ex

ln -sf $PWD/vimrc $HOME/.vimrc
ln -sf $PWD/vim $HOME/.vim 

ln -sf $PWD/wezterm.lua $HOME/.wezterm.lua
ln -sf $PWD/wezterm $HOME/.wezterm

ln -sf $PWD/tmux.conf $HOME/.tmux.conf

mkdir -p $HOME/.config || true
chmod 700 $HOME/.config
ln -sf $PWD/ssh/config $HOME/.ssh/config

mkdir -p $PWD/Personal || true
mkdir -p $PWD/Workspace || true
ln -sf $PWD/gitconfig $HOME/.gitconfig
ln -sf $PWD/Personal/gitconfig $HOME/Personal/.gitconfig
