#!/bin/sh

set -e

$ROOT_PART="/dev/mapper/arch--vg-root"

# Initialisation
loadkeys fr
timedatectl set-ntp true

echo '** Format paritions'
# mkfs.fat -F32 /dev/sdb1  (boot partition if EFI)
mkfs.ext4 $ROOT_PART

echo '** Mout partitions'
mount $ROOT_PART /mnt

# echo '** Update fatest repo' 
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
tee /etc/pacman.d/mirrorlist <<-EOF 
Server = http://arch.yourlabs.org/\$repo/os/\$arch
Server = http://archlinux.cu.be/\$repo/os/\$arch
Server = http://mirror.thomaskilian.net/archlinux/\$repo/os/\$arch
Server = http://mirror.metalgamer.eu/archlinux/\$repo/os/\$arch
Server = http://k42.ch/mirror/archlinux/\$repo/os/\$arch
Server = http://arch.eckner.net/archlinux/\$repo/os/\$arch
EOF

echo '** Install arch linux base'
pacstrap /mnt base
genfstab -U /mnt >> /mnt/etc/fstab

echo '** Please now copy arch-post-chroot.sh into /mnt/root/ and do:'
echo '# arch-chroot /mnt'

