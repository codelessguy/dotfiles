#!/bin/sh

set -e

# last update
sudo apt update && sudo apt upgrade

sudo apt install -y curl

# Term
sudo apt install -y terminator git gitk
# fonts-powerline fonts-firacode

# Monitor
sudo apt install -y htop iotop nethogs

# Editor
sudo apt install -y neovim python3-neovim
# vscode
# curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
# sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
# sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
# sudo apt install -y apt-transport-https
# sudo apt update
# sudo apt install -y code
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
sudo apt purge -y pidgin transmission-gtk modemmanager
# Remove games
sudo apt purge -y gnome-mines gnome-sudoku sgt-puzzles

# Disable cups (printer service):
sudo systemctl disable cups-browsed
sudo apt-get autoremove cups-daemon

# Remove apple bonjour discover services:
sudo apt purge -y avahi-daemon

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
