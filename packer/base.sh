#!/bin/bash
set -x

# Locales, uncomment if user-data didn't fix these
export LANGUAGE=en_US.UTF-8; export LANG=en_US.UTF-8; export LC_ALL=en_US.UTF-8;

# Set locale to en_US.UTF-8
cp /etc/locale.gen /etc/locale.gen.dist
sed -i -e "/^[^#]/s/^/#/" -e "/en_US.UTF-8/s/^#//" /etc/locale.gen

# American wifi
cp /var/cache/debconf/config.dat /var/cache/debconf/config.dat.dist
sed -i \
        -e "s/Value: en_GB.UTF-8/Value: en_US.UTF-8/" \
        -e "s/ locales = en_GB.UTF-8/ locales = en_US.UTF-8/" \
    /var/cache/debconf/config.dat

locale-gen
update-locale LANG=en_US.UTF-8

# Update & Install packages
apt-get update -qq
apt-get upgrade -qy
apt-get install -qy --no-install-recommends \
    vim \
    git \
    wget \
    curl \
    unzip \
    cloud-init \
    ssh-import-id \
    screen
apt-get autoremove -y

# Link cloud-init config to VFAT /boot partition
mkdir -p /var/lib/cloud/seed/nocloud-net
ln -s /boot/user-data /var/lib/cloud/seed/nocloud-net/user-data
ln -s /boot/meta-data /var/lib/cloud/seed/nocloud-net/meta-data
ln -s /boot/network-config /var/lib/cloud/seed/nocloud-net/network-config
