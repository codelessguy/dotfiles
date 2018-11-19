#!/bin/sh

set -e

# last update
sudo apt update && sudo apt upgrade

# Term
sudo apt install -y terminator fish git gitk fonts-powerline htop iotop nethogs fonts-firacode

# Editor
sudo apt install -y neovim python3-neovim
# vscode
sudo apt install -y curl
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y code
# yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install --no-install-recommends yarn
# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
# nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# Brower
sudo apt install -y chromium-browser
sudo apt install -y thunderbird

# Misc
sudo apt install -y clementine
sudo apt install -y virtualbox

# Games
sudo apt install -y steam

# Remove softwares
sudo apt purge -y gnome-software update-manager packagekit packagekit-tools
sudo apt purge -y pidgin
sudo apt purge -y transmission-gtk
sudo apt purge -y modemmanager
# Remove games
sudo apt purge -y gnome-mines gnome-sudoku sgt-puzzles

# Disable cups (printer service):
sudo systemctl disable cups-browsed
sudo apt-get autoremove cups-daemon

# Remove apple bonjour discover services:
sudo apt-get purge avahi-daemon

# XFCE
sudo apt purge -y xfce4-terminal

# LXQT
# sudo apt purge -y lxterminal
# sudo apt purge -y sylpheed
# sudo apt purge -y abiword
# sudo apt purge -y gnumeric

# sudo apt install -y libreoffice

# Clean
sudo apt autoremove && sudo apt clean

# Speed up boot: Remove hibernate to swap
echo 'RESUME=none' | sudo tee /etc/initramfs-tools/conf.d/resume
sudo update-initramfs -u
