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

echo "################################################################"
echo "#########           You got to reboot.                 #########"
echo "################################################################"
