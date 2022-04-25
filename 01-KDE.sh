#!/bin/bash
set -e
# Author	      :       Rodrigo Alan M. Carvalho

sudo pacman -S --noconfirm sddm plasma plasma-wayland-session powerdevil konsole dolphin ark kdeconnect kate krunner packagekit-qt5 kaccounts-providers

sudo systemctl enable sddm

echo ">> You got to reboot.<<"

