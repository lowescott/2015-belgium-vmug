#!/bin/bash

# Make directory for NoCloud cloud-init datasource
if [ ! -d "/var/lib/cloud/seed/nocloud" ]; then
    mkdir /var/lib/cloud/seed/nocloud
fi

# Put files into the correct locations for cloud-init
# First move the user-data file, if it exists in the home directory
if [ -f "/home/vagrant/user-data" ]; then
    mv /home/vagrant/user-data /var/lib/cloud/seed/nocloud/
fi

# Next move the meta-data file, if it exists in the home directory
if [ -f "/home/vagrant/meta-data" ]; then
    mv /home/vagrant/meta-data /var/lib/cloud/seed/nocloud/
fi

# Disable the TDNF ISO repository
sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/photon-iso.repo

# Update the TDNF cache
tdnf makecache

# Check for updates
tdnf check-update

# Update Docker
tdnf -y update docker