#!/bin/sh

set -e

# Config flags
NVIDIA=true
DESKTOP="i3" # Others: "openbox"

# Configure network
# sudo tee /etc/netctl/eth-auto <<-EOF
# Interface=enp3s0
# Connection=ethernet
# IP=dhcp
# EOF
# netctl start eth-auto
# netctl enable eth-auto

# Base dev packages with ntfs support
PKG="base-devel"
# NTFS support
PKG="ntfs-3g"
# Xorg
PKG+="xorg-server xorg-xinit xorg-xsetroot"
if [ "$NVIDIA" = true ] ; then
    PKG+="nvidia"
fi

if [ "$DESKTOP" = "openbox" ]; then
    PKG+="openbox obconf openbox-themes"
fi
if [ "$DESKTOP" = "i3" ]; then
    PKG+="i3"
fi
# Common desktop utils
PKG+="rofi feh"
# Terminal
PKG+="rxvt-unicode git tk zsh fzf"
# Terminal fonts
PKG+="powerline powerline-fonts terminus-font"
# Editor
# Use xclip to copy between neovim instances
PKG+="neovim xclip python-neovim"
# Deps for neovim plugins
PKG+="the_silver_searcher"
# Web browser
PKG+="chromium"
# Mail client
PKG+="thunderbird"
# Monitor
PKG+="htop iotop nethogs"
# Files
PKG+="ranger"
# Fonts
# Asian fonts (china, korean, japan...)
PKG+="noto-fonts-cjk noto-fonts-emoji noto-fonts ttf-dejavu ttf-liberation ttf-fira-code"
# For polybar (update check)
PKG+="pacman-contrib"

sudo pacman -S $PKG

# Terminal autologin at boot
cat <<EOF | sudo SYSTEMD_EDITOR=tee systemctl edit getty@tty1
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin xyz --noclear %I \$TERM
EOF

# Xorg
# sudo pacman -S xorg-server xorg-xinit xorg-xsetroot
# # Nvidia: add this
# sudo pacman -S nvidia
# # Openbox
# # sudo pacman -S openbox obconf openbox-themes
# # i3
# sudo pacman -S i3
# # Common desktop utils
# sudo pacman -S rofi feh

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
echo "xset r rate 200 50" >> ~/.xinitrc # Show pointer if no window
echo "setxkbmap -option caps:swapescape" >> ~/.xinitrc # Show pointer if no window
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

# Terminal
# sudo pacman -S terminator git tk zsh fzf
# # Terminal fonts
# sudo pacman -S powerline powerline-fonts terminus-font
#
# # Editor
# # Use xclip to copy between neovim instances
# sudo pacman -S neovim xclip python-neovim
# # Deps for neovim plugins
# sudo pacman -S the_silver_searcher
#
# # Web browser
# sudo pacman -S chromium
#
# # Mail
# sudo pacman -S thunderbird
#
# # Monitor
# sudo pacman -S htop iotop nethogs
#
# # Files
# sudo pacman -S ranger
#
# # Fonts
# # Asian fonts (china, korean, japan...)
# #sudo pacman -S adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts
# sudo pacman -S noto-fonts-cjk noto-fonts-emoji noto-fonts ttf-dejavu ttf-liberation ttf-fira-code

# Aur helper
cd ~/ && mkdir install && cd install
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~/

# Polybar
AUR_PKG="polybar siji-git"

yay -S $AUR_PKG

# Optimisation
echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/40-max-user-watches.conf
# source: Arch Linux - Best distro ever? | AkitaOnRails.com
sudo tee -a /etc/sysctl.d/99-sysctl.conf <<-EOF
vm.swappiness=1
vm.vfs_cache_pressure=50
vm.dirty_background_bytes=16777216
vm.dirty_bytes=50331648
EOF

sudo sysctl --system
