#!/bin/sh

set -e

# Config flags
NVIDIA=true
DESKTOP="openbox" # Others: "i3"

# Configure network (DISABLED at startup use network manager)
sudo tee /etc/netctl/eth-auto <<-EOF
Interface=enp3s0
Connection=ethernet
IP=dhcp
EOF
sudo netctl start eth-auto
# sudo netctl enable eth-auto

# Base dev packages with ntfs support
PKG="base-devel"
# NTFS support
PKG+=" ntfs-3g"
# Xorg
PKG+=" xorg-server xorg-xinit xorg-xsetroot"
if [ "$NVIDIA" = true ] ; then
    PKG+=" nvidia"
fi
# WM
if [ "$DESKTOP" = "openbox" ]; then
    PKG+="openbox obconf openbox-themes"
fi
if [ "$DESKTOP" = "i3" ]; then
    PKG+="i3"
fi
# Common desktop utils
PKG+=" rofi feh"
# Terminal
PKG+=" tilix git tk zsh fzf"
# Terminal fonts
PKG+=" powerline powerline-fonts terminus-font"
# Editor
# Use xclip to copy between neovim instances
PKG+=" neovim xclip python-neovim"
# Deps for neovim plugins
PKG+=" the_silver_searcher"
# Web browser
PKG+=" chromium firefox"
# Monitor
PKG+=" htop iotop nethogs"
# Files
PKG+=" ranger thunar"
# Fonts
# Asian fonts (china, korean, japan...)
PKG+=" noto-fonts-cjk noto-fonts-emoji noto-fonts ttf-dejavu ttf-liberation ttf-fira-code"
# For polybar (update check)
PKG+=" pacman-contrib"
# Network manager
PKG+=" networkmanager network-manager-applet"
# Python development
PKG+=" python-pipenv"
# Go lang development
PKG+=" go"
# VPN
PKG+=" openvpn networkmanager-openvpn"
# Postgresql
PKG+=" postgresql"

sudo pacman -S $PKG

# Terminal autologin at boot
cat <<EOF | sudo SYSTEMD_EDITOR=tee systemctl edit getty@tty1
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin xyz --noclear %I \$TERM
EOF

# Fr keyboard for xorg
sudo tee /etc/X11/xorg.conf.d/10-keyboard-layout.conf <<-EOF
Section "InputClass"
    Identifier         "Keyboard Layout"
    MatchIsKeyboard    "yes"
    Option             "XkbLayout"  "fr"
    Option             "XkbVariant" "latin9"
EndSection
EOF

# Configure xinit
head -n -5 /etc/X11/xinit/xinitrc > ~/.xinitrc # Remove last 5 lines
echo "xset r rate 200 50" >> ~/.xinitrc
# echo "setxkbmap -option caps:swapescape" >> ~/.xinitrc # Swap escape and caps lock keys
echo "xsetroot -cursor_name left_ptr" >> ~/.xinitrc # Show pointer if no window
if [ "$DESKTOP" = "openbox" ]; then
    echo "exec openbox-session" >> ~/.xinitrc # Add openbox at startup
fi
if [ "$DESKTOP" = "i3" ]; then
    echo "exec i3" >> ~/.xinitrc # Add i3 at startup
fi

tee ~/.xserverrc <<-EOF
#!/bin/sh
exec /usr/bin/Xorg -nolisten tcp "\$@" vt\$XDG_VTNR
EOF

# Autostart xorg at startup
cp /etc/skel/.bash_profile ~/
tee ~/.bash_profile <<-EOF
if [[ ! \$DISPLAY && \$XDG_VTNR -eq 1 ]]; then
  exec startx
fi
EOF

# Aur helper
cd ~/ && mkdir install && cd install
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~/

# Polybar
# AUR_PKG="polybar siji-git"

# yay -S $AUR_PKG

# Optimisation: increase file watches for IDE.
echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/40-max-user-watches.conf
# source: Arch Linux - Best distro ever? | AkitaOnRails.com
sudo tee -a /etc/sysctl.d/99-sysctl.conf <<-EOF
vm.swappiness=1
vm.vfs_cache_pressure=50
vm.dirty_background_bytes=16777216
vm.dirty_bytes=50331648
EOF

sudo sysctl --system

# Enable network manager at startup
sudo systemctl enable NetworkManager

# Init Postgresql
sudo -u postgres initdb --locale en_US.UTF-8 -E UTF8 -D '/var/lib/postgres/data'
sudo systemctl enable postgresql

# Copy configs
# TODO: need to cd where the script is !!!
# mkdir -p ~/.config/
# cp -r ./nvim ~/.config/
# cp .gitconfig ~/
