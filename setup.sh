#!/bin/bash

ln -s vimrc ~/.vimrc
ln -s vim ~/.vim

ln -s wezterm.lua ~/.wezterm.lua
ln -s wezterm ~/.wezterm

ln -s tmux.conf ~/.tmux.conf

mkdir 0700 -p ~/.config
ln -s ssh/config ~/.ssh/config

mkdir ~/Personal
mkdir ~/Workspace
ln -s gitconfig ~/.gitconfig
ln -s Personal/gitconfig ~/Personal/.gitconfig
