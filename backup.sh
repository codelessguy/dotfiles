#!/bin/sh

cp ~/.vimrc .
cp ~/.zshrc .
cp ~/.zpreztorc .
cp ~/.config/rofi-power.sh .

cp -r ~/.config/i3 .
cp -r ~/.config/ranger .
cd ranger; rm bookmarks history tagged; cd ..
cp -r ~/.config/polybar .
cp -r ~/.config/bspwm .
cp -r ~/.config/sxhkd .

pacman -Qqet > arch-pkg.txt
