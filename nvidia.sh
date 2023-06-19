#!/bin/bash

# Update system and install necessary packages
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm nvidia

# Install nvidia-dkms driver
sudo pacman -S --noconfirm nvidia-dkms

# Add nvidia-dkms to initramfs and kernel parameters
echo "nvidia_drm.modeset=1" | sudo tee -a /boot/loader/entries/arch.conf

# Update initramfs
sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img

# Add nvidia.conf file for modprobe
echo "options nvidia-drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf

# Install additional packages
sudo pacman -S --noconfirm qt5-wayland qt5ct libva
yay -S --noconfirm hyprland-nvidia-git nvidia-vaapi-driver-git

# Reboot the system
sudo reboot
