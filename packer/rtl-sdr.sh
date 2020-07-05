#!/bin/bash
set -x

# Install packages
apt-get install -qy \
    build-essential \
    cmake \
    libasound2-dev \
    libusb-1.0-0-dev

# Direwolf Setup
cd /home/pi
git clone https://github.com/wb2osz/direwolf.git
cd direwolf
make
make install
make install-conf

# RTL-SDR Library
cd /home/pi
git clone git://git.osmocom.org/rtl-sdr.git
cd rtl-sdr
mkdir build
cd build
cmake ../ -DINSTALL_UDEV_RULES=ON -DDETACH_KERNEL_DRIVER=ON
make
make install
ldconfig
