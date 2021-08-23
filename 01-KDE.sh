#!/bin/bash
set -e
# Author	      :       Rodrigo Alan M. Carvalho


#sudo pacman -S sddm plasma ark kdeconnect plasma-wayland-session  --noconfirm --needed
sudo pacman -S plasma plasma-wayland-session konsole dolphin ark kwrite kcalc spectacle krunner partitionmanager packagekit-qt5 xdg-desktop-portal-kde  sddm --noconfirm --needed

sudo systemctl enable sddm
sudo systemctl enable bluetooth.service


echo ">> You got to reboot.<<"

