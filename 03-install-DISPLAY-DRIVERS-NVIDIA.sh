#!/bin/bash
set -e
################################################################################
# Author	:	Erik Dubois					       #
# Modicificacão :       Rodrigo Alan M. Carvalho			       #
################################################################################

#gpu
sudo pacman -S nvidia-dkms
sudo pacman -S nvidia-utils
sudo pacman -S lib32-nvidia-utils
sudo pacman -S opencl-nvidia
sudo pacman -S lib32-opencl-nvidia
sudo pacman -S nvidia-settings

echo "################################################################"
echo "#########           You got to reboot. opencl-nvidia                 #########"
echo "################################################################"
