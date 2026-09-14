#!/bin/bash

# Tile & Window Management
gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Super>bracketleft']"
gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Super>bracketright']"
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>equal']"
gsettings set org.gnome.desktop.wm.keybindings unmaximize "['<Super>minus']"

# Unbind default Dock app shortcuts (Super + 1..6)
for i in {1..6}; do
  gsettings set org.gnome.shell.keybindings switch-to-application-$i "[]"
done

# Disable dynamic workspaces and set count to 6
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 6

# Bind Super + 1..6 to Switch Workspaces
for i in {1..6}; do
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$i']"
done
