#!/bin/bash

gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Super>bracketleft']"
gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Super>bracketright']"
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>equal']"
gsettings set org.gnome.desktop.wm.keybindings unmaximize "['<Super>minus']"

