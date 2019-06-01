#!/bin/bash
set -e
################################################################################
# Author	 	:	Erik Dubois	                               #
# Modicificacão  	:       Rodrigo Alan M. Carvalho                       #
################################################################################

echo "Instalando o  Kernel Zen."

sudo pacman -S linux-zen linux-zen-headers --noconfirm --needed 
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "###############################################################"
echo "#### Reiniciar e escolher no grub depois usar o SCRIPT-000 ####"
echo "###############################################################"
