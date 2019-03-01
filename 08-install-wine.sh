#!/bin/bash
set -e
################################################################################
# Author	:	Erik Dubois					       #
# Modicificacão :       Rodrigo Alan M. Carvalho			       #
################################################################################


sudo pacman -S $(pactree -l wine) --noconfirm --needed

WINEARCH=win32 WINEPREFIX=~/.win32 winecfg


echo "################################################################"
echo "#########           You got to reboot.                 #########"
echo "################################################################"