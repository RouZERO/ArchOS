#!/bin/bash
set -e
################################################################################
# Author	 	:	Erik Dubois	                               #
# Modicificacão  	:       Rodrigo Alan M. Carvalho                       #
################################################################################

echo "Instalando o  Kernel Zen."

sudo pacman -S --noconfirm --needed linux-zen linux-zen-headers
sudo pacman -S --noconfirm --needed linux-zen-headers
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "###############################################################"
echo "#### Reiniciar e escolher no grub depois usar o SCRIPT-000 ####"
echo "###############################################################"
