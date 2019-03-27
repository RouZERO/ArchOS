#!/bin/bash
set -e
################################################################################
# Author	:	Erik Dubois					       #
# Modicificacão :       Rodrigo Alan M. Carvalho			       #
################################################################################

#gpu
sudo pacman -S nvidia-dkms --noconfirm --needed
sudo pacman -S nvidia-utils --noconfirm --needed
sudo pacman -S lib32-nvidia-utils --noconfirm --needed
sudo pacman -S opencl-nvidia --noconfirm --needed
sudo pacman -S lib32-opencl-nvidia --noconfirm --needed
sudo pacman -S nvidia-settings --noconfirm --needed

#vulkan
sudo pacman -S vulkan-icd-loader --noconfirm --needed
sudo pacman -S lib32-vulkan-icd-loader --noconfirm --needed


#sound
sudo pacman -S pulseaudio --noconfirm --needed
sudo pacman -S pulseaudio-alsa --noconfirm --needed
sudo pacman -S pavucontrol  --noconfirm --needed
sudo pacman -S alsa-utils alsa-plugins alsa-lib alsa-firmware --noconfirm --needed
sudo pacman -S gstreamer --noconfirm --needed
sudo pacman -S gst-plugins-good gst-plugins-bad gst-plugins-base gst-plugins-ugly --noconfirm --needed
sudo pacman -S volumeicon --noconfirm --needed
sudo pacman -S playerctl --noconfirm --needed

#bluetooth
sudo pacman -S --noconfirm --needed pulseaudio-bluetooth
sudo pacman -S --noconfirm --needed bluez
sudo pacman -S --noconfirm --needed bluez-libs
sudo pacman -S --noconfirm --needed bluez-utils
sudo pacman -S --noconfirm --needed bluez-firmware
sudo pacman -S --noconfirm --needed blueberry
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf

#NTFS
sudo pacman -S --noconfirm --needed ntfs-3g

echo "################################################################"
echo "#########           You got to reboot.                 #########"
echo "################################################################"
