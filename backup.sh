#!/bin/sh

cp ~/.vimrc .
cp ~/.zshrc .
cp ~/.zpreztorc .

cp -r ~/.config/i3 .
cp -r ~/.config/ranger .
cp -r ~/.config/polybar .
cp -r ~/.config/bspwm .
cp -r ~/.config/sxhkd .

pacman -Qqet > arch-pkg.txt
