#!/bin/bash
set -e
################################################################################
# Author	:	Erik Dubois					       #
# Modicificacão :       Rodrigo Alan M. Carvalho			       #
################################################################################


echo "Habilitando ntfs."

sudo pacman -S --noconfirm --needed ntfs-3g

echo "###############################################################"
echo "####                     Reiniciar                         ####"
echo "###############################################################"