#!/bin/sh

set -e

# Configure network
sudo tee /etc/netctl/eth-auto <<-EOF
Interface=enp3s0
Connection=ethernet
IP=dhcp
EOF
netctl start eth-auto
netctl enable eth-auto

# Base packages
sudo pacman -S base-devel

# Terminal autologin at boot
cat <<EOF | sudo SYSTEMD_EDITOR=tee systemctl edit getty@tty1
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin xyz --noclear %I \$TERM
EOF

# Xorg
sudo pacman -S xorg-server xorg-xinit nvidia xorg-xsetroot
# Pour bspwm
#sudo pacman -S bspwm sxhkd
# Openbox
sudo pacman -S openbox obconf openbox-themes
# Common desktop utils
sudo pacman -S rofi feh

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
echo "xsetroot -cursor_name left_ptr" >> ~/.xinitrc # Show pointer if no window
echo "exec bspwm" >> ~/.xinitrc # Add bspwm at startup

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
sudo pacman -S terminator git tk zsh powerline powerline-fonts fzf terminus-font
# Terminal fonts
sudo pacman -S powerline powerline-fonts terminus-font

# Editor
# Use xclip to copy between neovim instances
sudo pacman -S neovim xclip python-neovim
# Deps for neovim plugins
sudo pacman -S the_silver_searcher

# Web browser
sudo pacman -S firefox chromium

# Mail
sudo pacman -S thunderbird

# Monitor
sudo pacman -S htop iotop nethogs

# Files
sudo pacman -S ranger

# Fonts
# Asian fonts (china, korean, japan...)
#sudo pacman -S adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts
sudo pacman -S noto-fonts-cjk noto-fonts-emoji noto-fonts

# Aur helper
cd ~/ && mkdir install && cd install
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~/

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
