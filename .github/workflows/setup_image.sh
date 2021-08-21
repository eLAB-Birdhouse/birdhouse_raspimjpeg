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
sudo apt-get install -y git libssl-dev  # cmake

# Download, deflate, build and install cmake
wget https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1.tar.gz
tar -xf cmake-3.21.1.tar.gz
cd cmake-3.21.1
./bootstrap -- -DCMAKE_BUILD_TYPE:STRING=Release
make
make install

# Enable camera after next reboot (optional) [not possible with chroot]
# sudo raspi-config nonint do_camera 0 && sudo reboot

# Clone raspimjpeg code
git clone https://github.com/roberttidey/userland.git

# Compile project
cd userland
sudo chmod +x ./buildme
./buildme  # -DCMAKE_TOOLCHAIN_FILE=toolchain_file.cmake

# cd bin
