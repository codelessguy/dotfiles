#!/bin/sh
set -e

DRIVE=/dev/sdb
LVM=true

# LVM
if [ "$LVM" = true ]; then
    ln -s /hostlvm /run/lvm
fi

echo '** Configure Time'
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc

echo '** Update fatest repo'
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
tee /etc/pacman.d/mirrorlist <<-EOF
Server = https://mirror.cyberbits.eu/archlinux/\$repo/os/\$arch
Server = https://mirror.netcologne.de/archlinux/\$repo/os/\$arch
Server = https://mirror.oldsql.cc/archlinux/\$repo/os/\$arch
EOF
# sudo sh -c 'rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist'
# curl -s "https://www.archlinux.org/mirrorlist/?country=FR&country=GB&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 - > /etc/pacman.d/mirrorlist

echo '** Configure language'
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=fr" >> /etc/vconsole.conf

echo '** Network'
echo "xyz" >> /etc/hostname
tee -a /etc/hosts <<-EOF
127.0.0.1	localhost
::1		    localhost
EOF

pacman -Sy --noconfirm lvm2
echo '** Configure lvm at boot'
if [ "$LVM" = true ]; then
    sed -i 's/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS=(base udev autodetect modconf block lvm2 filesystems keyboard fsck)/g' /etc/mkinitcpio.conf
fi
mkinitcpio -p linux

echo '** Change ROOT password'
passwd

echo '** Add user: XYZ'
useradd -m -G wheel -s /bin/bash xyz
passwd xyz
pacman -Sy --noconfirm sudo nano
EDITOR=nano visudo

echo '** Install grub'
pacman -Sy --noconfirm grub
grub-install --target=i386-pc ${DRIVE}
# UEFI
# pacman -S grub efibootmgr
# grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub

grub-mkconfig -o /boot/grub/grub.cfg
