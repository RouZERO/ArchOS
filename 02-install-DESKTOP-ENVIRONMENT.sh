#!/bin/bash
set -e
# Author	:	Erik Dubois
# Modicificacão :       Rodrigo Alan M. Carvalho


sudo pacman -S gnome-shell gnome-tweak-tool gnome-control-center nautilus gdm tilix chrome-gnome-shell evolution-data-server --noconfirm --needed
sudo systemctl enable gdm


echo ">> You got to reboot.<<"

