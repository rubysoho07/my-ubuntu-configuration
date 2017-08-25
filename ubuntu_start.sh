#!/bin/bash

# To add repositories for Java
sudo add-apt-repository ppa:webupd8team/java

# Update and upgrade OS and applications. 
sudo apt update
sudo apt -y upgrade
sudo apt -y autoremove

# Install vim.
sudo apt-get -y install vim

# To set resolution of grub
sudo sed 's/#GRUB_GFXMODE=640x480/GRUB_GFXMODE=1024x768' /etc/default/grub
sudo update-grub

# To use exFAT formatted SD(or MicroSD) cards
sudo apt-get -y install exfat-fuse exfat-utils

# Install SMPlayer
sudo apt-get -y install smplayer

# Install Java
sudo apt-get -y install oracle-java8-installer

# Disable avahi daemon
sudo sed 's/AVAHI_DAEMON_DETECT_LOCAL=1/AVAHI_DAEMON_DETECT_LOCAL=0' /usr/lib/avahi/avahi-daemon-check-dns.sh
sudo sed 's/AVAHI_DAEMON_DETECT_LOCAL=1/AVAHI_DAEMON_DETECT_LOCAL=0' /etc/default/avahi-daemon


