#!/bin/bash

# Step 1: Hyprland wrapper configuration
wrapper_path="~/git/arch-hyprland/wrapper/wrapper.sh"  # Replace with the actual path to your wrapper
chmod +x "$wrapper_path"

cat > "$wrapper_path" << EOF
#!/bin/bash

cd~

export _JAVA_AWT_WM_NOREPARENTING=1
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_DESKTOP=Hyprland
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export GBM_BACKEND=nvidia-drm

exec Hyprland
EOF

# Step 2: Installing NVIDIA DKMS driver
echo "nvidia nvidia_modeset nvidia_uvm nvidia_drm" >> /etc/mkinitcpio.conf
mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img

echo "options nvidia-drm modeset=1" >> /etc/modprobe.d/nvidia.conf

# Step 3: Updating kernel parameters
grub_config="/boot/grub/grub.cfg"
grub_backup="/boot/grub/grub.cfg.bak"
cp "$grub_config" "$grub_backup"

sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="nvidia_drm.modeset=1 ibt=off /' "$grub_config"
grub-mkconfig -o "$grub_config"

# Step 4: Installing nvidia-exec
git clone https://github.com/pedro00dk/nvidia-exec.git
cd nvidia-exec
make
sudo make install
cd ..
rm -rf nvidia-exec

# Step 5: Adding second monitor to Hyprland config
# Modify the Hyprland config file as per the instructions in the tutorial

# Step 6: Loading kernel modules
sudo nvx on

# Step 7: Verify monitor connection
# Make sure to plug in your monitor

echo "Multi-monitor setup completed!"
# instructions from https://www.reddit.com/r/wayland/comments/zuliyx/tutorial_on_multi_monitor_setup_nvidiaintel/ 
