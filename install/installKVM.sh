# Install all packages
sudo pacman -Syy
sudo pacman -S archlinux-keyring
sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat
sudo pacman -S ebtables iptables

# Install libguestfs
sudo pacman -S libguestfs

# Start KVM libvirt service
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

# Enable normal user account to use KVM
echo "Open this file: sudo vim /etc/libvirt/libvirtd.conf"
echo 'change the unix_sock_group to: unix_sock_group = "libvirt"'
echo 'Now set the permissions to: unix_sock_rw_perms = "0770"'

# Add User to libvirt group
sudo usermod -a -G libvirt $(whoami)
newgrp libvirt

# Restart libvirt deamon
sudo systemctl restart libvirtd.service
