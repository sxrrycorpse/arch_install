#!/bin/bash

# Automated-Arch-Install-w/Bash

# Update mirrorlist
reflector --country India --latest 10 --sort rate --save /etc/pacman.d/mirrorlist --verbose

# Disk partition
sgdisk -Z /dev/vda
sgdisk -n 1::+1G -c 1:"EFI BOOT Partition" -t 1:ef00 /dev/vda
sgdisk -n 2:: -c 2:"Linux Partition" -t 2:8300 /dev/vda
sgdisk -p /dev/vda

# Format partitions
mkfs.ext4 /dev/vda2
mkfs.fat -F 32 /dev/vda1

# Mount filesystems
mount /dev/vda2 /mnt
mount --mkdir /dev/vda1 /mnt/boot
