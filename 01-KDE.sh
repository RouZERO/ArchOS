#!/bin/bash
set -e
# Author	      :       Rodrigo Alan M. Carvalho


#sudo pacman -S sddm plasma ark kdeconnect plasma-wayland-session  --noconfirm --needed
sudo pacman -S --noconfirm sddm plasma plasma-wayland-session powerdevil konsole dolphin ark kate krunner packagekit-qt5 xdg-desktop-portal-kde

sudo systemctl enable sddm

echo ">> You got to reboot.<<"

