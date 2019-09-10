#!/bin/sh

set -e

# LVM
ln -s /hostlvm /run/lvm

echo '** Configure Time'
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc

echo '** Update fatest repo' 
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
tee /etc/pacman.d/mirrorlist <<-EOF 
Server = http://archlinux.de-labrusse.fr/\$repo/os/\$arch
Server = http://archlinux.vi-di.fr/\$repo/os/\$arch
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

echo '** Configure lvm at boot'
sed -i 's/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS=(base udev autodetect modconf block lvm2 filesystems keyboard fsck)/g' /etc/mkinitcpio.conf
mkinitcpio -p linux

echo '** Change root password'
passwd

echo '** Add user'
useradd -m -G wheel -s /bin/bash xyz
passwd xyz
pacman -S sudo
EDITOR=nano visudo

echo '** Install grub'
pacman -S grub
grub-install --target=i386-pc /dev/sdb
# UEFI
# pacman -S grub efibootmgr
# grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub

grub-mkconfig -o /boot/grub/grub.cfg

echo '** Please now do:'
echo 'exit'
echo 'sync'
echo 'umount -R /mnt'
echo 'reboot'
