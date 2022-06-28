#!/usr/bin/env bash

set -e

DISK="/dev/sda"
BOOT_PARTITION="${DISK}1"
ROOT_PARTITION="${DISK}2"

TIMEZONE="Asia/Seoul"



############
# Keyboard #
############

loadkeys uk



########
# Time #
########

ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime

hwclock --systohc

timedatectl --no-ask-password set-timezone ${TIMEZONE}
timedatectl --no-ask-password set-ntp 1



################
# Setup Pacman #
################

pacman -Sy

# Enable parallel downloads in Pacman
sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf



#############
# Partition #
#############

pacman -S gptfdisk --noconfirm --needed

# Zap disk
sgdisk -Z ${DISK}

# Set sector alignment to 2048
sgdisk -a 2048 -o ${DISK}

# Create boot partition
sgdisk -n 1:0:+500M ${DISK}

# Create main partition
sgdisk -n 2:0:0 ${DISK}

# Set partition types
sgdisk -t 1:ef00 ${DISK}
sgdisk -t 2:8300 ${DISK}

# Label partitions
sgdisk -c 1:"UEFISYS" ${DISK}
sgdisk -c 2:"ROOT" ${DISK}

# Make filesystems
mkfs.vfat -F32 -n "UEFISYS" "${BOOT_PARTITION}"
mkfs.ext4 -L "ROOT" "${ROOT_PARTITION}"



####################
# Mount partitions #
####################

mount -t ext4 "${ROOT_PARTITION}" /mnt

mkdir -p /mnt/boot/

mount -t vfat "${BOOT_PARTITION}" /mnt/boot/



############
# Pacstrap #
############

pacstrap /mnt base base-devel linux linux-firmware grub-efi-x86_64 efibootmgr dhcpcd --noconfirm --needed

genfstab -U /mnt >> /mnt/etc/fstab

# Enable DHCPCD so that we have networking
arch-chroot /mnt systemctl enable dhcpcd



########
# GRUB #
########

arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch

sed -i "s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g" /mnt/etc/default/grub

arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg



################
# User account #
################

# Add user
arch-chroot /mnt useradd -m -G wheel -s /bin/bash sidroberts

# Enable wheel group to sudo
arch-chroot /mnt sed -i 's/^# %wheel ALL=(ALL:ALL) ALL$/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Set the password
echo "sidroberts:1234" | arch-chroot /mnt chpasswd



##########
# Reboot #
##########

systemctl reboot
