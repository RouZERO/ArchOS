#!/bin/bash
set -e
# Author	:	Erik Dubois
# Modicificacão :       Rodrigo Alan M. Carvalho


sudo pacman -S gnome-shell gnome-tweak-tool gnome-control-center gnome-keyring nautilus gdm tilix evolution-data-server noto-fonts-cjk --noconfirm --needed
sudo systemctl enable gdm


echo ">> You got to reboot.<<"

