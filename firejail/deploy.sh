#!/bin/sh

rm -rf /home/xyz/.fjdirs

mkdir -p /home/xyz/.fjdirs/chromium-youtube
sudo cp chromium-youtube.desktop /usr/share/applications/

mkdir -p /home/xyz/.fjdirs/chromium-dev
sudo cp chromium-dev.desktop /usr/share/applications/
