#!/bin/sh

set -e

# Initialisation
loadkeys fr
timedatectl set-ntp true

# Format paritions
mkfs.fat -F32 /dev/sdb1
mkfs.ext4 /dev/mapper/vg0-lroot
# VM
#mkfs.ext4 /dev/sda1

# Mout patitions
mount /dev/mapper/vg0-lroot /mnt
mkdir /mnt/boot
mount /dev/sdb1 /mnt/boot
# VM
#mount /dev/sda1 /mnt

# Install arch linux base
pacstrap /mnt base
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

# Configure Time
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc

# Configure language
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=fr" >> /etc/vconsole.conf

# Network
echo "xyz" >> /etc/hostname
echo "127.0.0.1	localhost
::1		localhost" >> /etc/hosts

# Configure lvm at boot
sed -i 's/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS=(base udev autodetect modconf block lvm2 filesystems keyboard fsck)/g' /etc/mkinitcpio.conf
mkinitcpio -p linux

# Change root passwotrd
passwd

# Add user
useradd -m -G wheel -s /bin/bash xyz
passwd xyz
pacman -S sudo
EDITOR=nano visudo

# BIOS
#pacman -S grub
#grub-install --target=i386-pc /dev/sda
# UEFI
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub

grub-mkconfig -o /boot/grub/grub.cfg

# Exit chroot
exit
sync
umount -R /mnt
reboot
