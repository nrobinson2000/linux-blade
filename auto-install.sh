#!/usr/bin/env bash

# Add PPAs for openrazer, polychromatic, numix, and adapta
sudo add-apt-repository ppa:openrazer/stable
sudo add-apt-repository ppa:polychromatic/stable
sudo add-apt-repository ppa:numix/ppa
sudo add-apt-repository ppa:tista/adapta
sudo add-apt-repository ppa:libratbag-piper/piper-libratbag-git

# Update package list
sudo apt update

# Install everything
sudo apt install -y chromium-browser openrazer-meta polychromatic \
numix-icon-theme-circle adapta-gtk-theme docky conky wireshark* \
piper

# Allow non-superuser to capture packets
sudo adduser "$USER" wireshark

# Install comfortable-swipe
sudo apt-get -y install git libinput-tools libxdo-dev g++
git clone https://github.com/Hikari9/comfortable-swipe.git --depth 1
echo "$(cd comfortable-swipe && bash install)"
sudo gpasswd -a "$USER" $(ls -l /dev/input/event* | awk '{print $4}' | head --line=1)

# Install conkyrc
cp config/conkyrc ~/.conkyrc

# Install comfortable-swipe.conf
cp -f config/comfortable-swipe.conf /usr/local/share/comfortable-swipe/comfortable-swipe.conf

# Add conky and docky to startup applications
[ -d ~/.config/autostart ] || mkdir -p ~/.config/autostart
cp -f apps/conky.desktop ~/.config/autostart
cp -f apps/docky.desktop ~/.config/autostart

# Apply Desktop Settings
dconf load / < config/desktop-settings.conf
