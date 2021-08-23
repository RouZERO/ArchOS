#!/bin/bash
set -e
# Author	      :	      Erik Dubois
# Modicificacão :       Rodrigo Alan M. Carvalho


sudo pacman -S sddm plasma kde-applications --noconfirm --needed
sudo systemctl enable sddm


echo ">> You got to reboot.<<"

