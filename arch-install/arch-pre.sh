#!/bin/sh
set -e

LVM=false

formatsdd(){
    # mkfs.fat -F32 /dev/sdb1  (boot partition if EFI)
    mkfs.ext4 /dev/mapper/arch--vg-root
    mount /dev/mapper/arch--vg-root /mnt
}

# In virtual box, copy this file with the 10.0.2.2 address
formatvm(){
    # Create partition
    parted /dev/sda mklabel msdos
    parted /dev/sda mkpart primary 0% 100%

    mkfs.ext4 /dev/sda1
    mount /dev/sda1 /mnt
}

# Initialisation
loadkeys fr
timedatectl set-ntp true

# formatsdd
formatvm

# echo '** Update fatest repo' 
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
tee /etc/pacman.d/mirrorlist <<-EOF
Server = https://mirror.cyberbits.eu/archlinux/\$repo/os/\$arch
Server = http://archlinux.mirrors.ovh.net/archlinux/\$repo/os/\$arch
EOF

echo '** Install arch linux base'
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

# LVM
if [ "$LVM" = true ]; then
    mkdir /mnt/hostlvm
    mount --bind /run/lvm /mnt/hostlvm
fi

cp ./arch-post.sh /mnt/arch-post.sh
arch-chroot /mnt ./arch-post.sh

# Clean up and reboot
rm /mnt/arch-post.sh
sync
umount -R /mnt
reboot
