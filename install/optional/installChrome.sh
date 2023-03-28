#!/bin/bash

# Install required packages
sudo pacman -Syu --noconfirm base-devel wget

# Download the Google Chrome package
cd /tmp/
rm -f google-chrome-stable.rpm
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

# Install the Google Chrome package
sudo pacman -U --noconfirm google-chrome-stable.rpm

# Clean up
rm google-chrome-stable.rpm

echo "Google Chrome has been installed."

