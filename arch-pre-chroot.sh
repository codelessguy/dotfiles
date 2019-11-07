#!/bin/sh

set -e

# Initialisation
loadkeys fr
timedatectl set-ntp true

echo '** Format paritions'
# mkfs.fat -F32 /dev/sdb1  (boot partition if EFI)
mkfs.ext4 /dev/mapper/arch--vg-root

echo '** Mout partitions'
mount /dev/mapper/arch--vg-root /mnt

# echo '** Update fatest repo' 
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
tee /etc/pacman.d/mirrorlist <<-EOF
Server = http://archlinux.de-labrusse.fr/\$repo/os/\$arch
Server = http://archlinux.vi-di.fr/\$repo/os/\$arch
EOF

echo '** Install arch linux base'
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

# LVM
mkdir /mnt/hostlvm
mount --bind /run/lvm /mnt/hostlvm

echo '** Please now copy arch-post-chroot.sh into /mnt/root/ and do:'
echo '# arch-chroot /mnt'
