#!/bin/sh

gsettings set org.gnome.shell.overrides dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 9

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Alt>ampersand']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Alt>eacute']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Alt>quotedbl']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Alt>apostrophe']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Alt>parenleft']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Alt>minus']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 "['<Alt>egrave']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 "['<Alt>underscore']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9 "['<Alt>ccedilla']"

gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Shift><Alt>ampersand']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Shift><Alt>eacute']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Shift><Alt>quotedbl']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Shift><Alt>apostrophe']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5 "['<Shift><Alt>parenleft']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6 "['<Shift><Alt>minus']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7 "['<Shift><Alt>egrave']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8 "['<Shift><Alt>underscore']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9 "['<Shift><Alt>ccedilla']"

gsettings set org.gnome.desktop.wm.preferences workspace-names "[\"1\", \"2\", \"3\", \"4\", \"5\", \"6\", \"7\", \"8\", \"9\"]"
