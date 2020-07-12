#!/bin/sh

set -e

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd ${SCRIPTPATH}

DESKTOP_VM=false
NETWORK_ETH=enp3s0

#DESKTOP_VM=true
#NETWORK_ETH=ens3

# Configure network (DISABLED at startup use network manager)
# No systemctl network
#sudo tee /etc/netctl/eth-auto <<-EOF
#Interface=enp3s0
#Connection=ethernet
#IP=dhcp
#EOF
#sudo netctl start eth-auto
#sudo netctl enable eth-auto

sudo tee /etc/systemd/network/20-wired.network <<-EOF
[Match]
Name=${NETWORK_ETH}

[Network]
DHCP=ipv4
EOF
sudo systemctl start systemd-networkd.service
sudo systemctl start systemd-resolved.service

# Xorg
PKG+="xorg-server xorg-xinit xorg-xsetroot"
# NTFS support
PKG+=" ntfs-3g"
PKG+=" gcc make"
# WM
# PKG+=" i3-gaps i3status i3blocks dmenu"
# PKG+=" xfce4"
# PKG+=" openbox"
# PKG+=" rofi"
# Common desktop utils
# PKG+=" stow"
# Terminal
# PKG+=" terminator"
# Web browser
PKG+=" firefox"
# Network manager
# PKG+=" networkmanager network-manager-applet"

if [ "$DESKTOP_VM" = false ]; then
    PKG+=" nvidia"
    # Base development packages
    PKG=" base-devel git tk zsh fzf"
    # Terminal fonts
    #PKG+=" powerline powerline-fonts terminus-font"
    # Fonts
    # Asian fonts (china, korean, japan...)
    #PKG+=" noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttf-liberation ttf-fira-code"
    # Editor
    # Use xclip to copy between neovim instances
    PKG+=" neovim xclip python-neovim"
    # Deps for neovim plugins
    PKG+=" the_silver_searcher"
    # Monitor
    PKG+=" htop iotop nethogs"
    # Files
    #PKG+=" thunar"
    # Python development
    #PKG+=" python-pipenv"
    # Go lang development
    #PKG+=" go"
    # VPN
    #PKG+=" openvpn networkmanager-openvpn"
    # Postgresql
    # PKG+=" postgresql"
# else
    # PKG+=" virtualbox-guest-utils xf86-video-vmware"
    # PKG+=" linux-headers"
fi

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
	Option             "XkbOptions" "caps:swapescape"
EndSection
EOF

# Configure xinit
# head -n -5 /etc/X11/xinit/xinitrc > ~/.xinitrc # Remove last 5 lines
# echo "xset r rate 200 50" >> ~/.xinitrc
# echo "setxkbmap -option caps:swapescape" >> ~/.xinitrc # Swap escape and caps lock keys
# echo "xsetroot -cursor_name left_ptr" >> ~/.xinitrc # Show pointer if no window
# echo "exec openbox-session" >> ~/.xinitrc # Add openbox at startup*
# echo "exec i3" >> ~/.xinitrc # Add i3 at startup
# echo "exec startxfce4" >> ~/.xinitrc # Add i3 at startup
# echo "exec sowm" >> ~/.xinitrc # Add openbox at startup*

tee ~/.xserverrc <<-EOF
#!/bin/sh
exec /usr/bin/Xorg -nolisten tcp "\$@" vt\$XDG_VTNR
EOF

# Autostart xorg at startup
# cp /etc/skel/.bash_profile ~/
# tee ~/.bash_profile <<-EOF
# if [[ ! \$DISPLAY && \$XDG_VTNR -eq 1 ]]; then
#     exec startx
# fi
# EOF

# Aur helper
# cd ~/ && mkdir install && cd install
# git clone https://aur.archlinux.org/yay.git
# cd yay
# makepkg -si
# cd ~/

# Polybar
# AUR_PKG="polybar siji-git"

# yay -S $AUR_PKG

if [ "$DESKTOP_VM" = false ]; then
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
fi

# Enable network manager at startup
# sudo systemctl enable NetworkManager

# Init Postgresql
# sudo -u postgres initdb --locale en_US.UTF-8 -E UTF8 -D '/var/lib/postgres/data'
# sudo systemctl enable postgresql

# Install config files
# mkdir -p ~/.config
# cd ${SCRIPTPATH}/stow
# stow -t ~ *

# if [ "$DESKTOP_VM" = false ]; then
#     cp .gitconfig ~
# else
#     sudo systemctl enable vboxservice.service
# fi

# if [ "$DESKTOP_VM" = true ]; then
#     # Install virtualbox guest addons
#     wget https://download.virtualbox.org/virtualbox/6.0.14/VBoxGuestAdditions_6.0.14.iso
#     sudo mount ./VBoxGuestAdditions_6.0.14.iso /mnt
#     sudo /mnt/VBoxLinuxAdditions.run
#     sudo umount /mnt
# fi
