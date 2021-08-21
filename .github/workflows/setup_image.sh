#!/bin/bash

# Check for sudo permissions
if [ "$EUID" != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

# Get architecture
echo "Architecture"
uname -m

# Update and upgrade packages
sudo apt-get update
sudo apt-get full-upgrade -y

sudo apt-get install -y git cmake

# Enable camera after next reboot (optional) [not possible with chroot]
# sudo raspi-config nonint do_camera 0 && sudo reboot

# Clone raspimjpeg code
git clone https://github.com/roberttidey/userland.git

# Compile project
cd userland
sudo chmod +x ./buildme
./buildme  # -DCMAKE_TOOLCHAIN_FILE=toolchain_file.cmake

# cd bin
