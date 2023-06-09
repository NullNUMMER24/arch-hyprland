#!/bin/bash

# Add nvidia_drm.modeset=1 to GRUB_CMDLINE_LINUX_DEFAULT
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="\(.*\)"/GRUB_CMDLINE_LINUX_DEFAULT="\1 nvidia_drm.modeset=1"/' /etc/default/grub

# Update GRUB configuration
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Add modules to mkinitcpio.conf
sudo sed -i 's/^MODULES=.*$/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf

# Generate initramfs image
sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img

# Create or modify nvidia.conf
echo "options nvidia-drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf

# !!!!Run as sudo!!!!
