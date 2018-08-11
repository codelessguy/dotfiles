#!/bin/sh

set -e

# Term
sudo apt install -y terminator zsh git gitk

# Editor
sudo apt install -y neovim-qt python3-neovim

# Brower
sudo apt install -y chromium-browser

sudo apt install -y virtualbox

# Games
sudo apt install -y steam

# Remove softwares
sudo apt purge gnome-software
sudo apt purge pidgin
sudo apt remove xfce4-terminal
sudo apt purge transmission-gtk
# Remove games
sudo apt purge gnome-mines gnome-sudoku sgt-puzzles

sudo apt autoremove && sudo apt autoclean
