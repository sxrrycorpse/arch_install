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

# Install essential packages
pacstrap -K /mnt base base-devel linux linux-firmware amd-ucode neovim grub man-db tealdeer

# System configuration
genfstab -U /mnt >> /mnt/etc/fstab

# Timezone
arch-chroot /mnt ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
arch-chroot /mnt hwclock --systohc

# Localization
arch-chroot /mnt sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
arch-chroot /mnt locale-gen
touch /mnt/etc/locale.conf
echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf

# Hostname
touch /mnt/etc/hostname
echo "aetherius" > /mnt/etc/hostname

# Grub-install
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
