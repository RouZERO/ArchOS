#!/bin/bash
set -e
# Author	      :       Rodrigo Alan M. Carvalho


sudo pacman -S sddm plasma ark kdeconnect  --noconfirm --needed
sudo systemctl enable sddm


echo ">> You got to reboot.<<"

