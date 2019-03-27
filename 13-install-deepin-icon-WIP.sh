#!/bin/bash
set -e
################################################################################
# Author	:	Erik Dubois					       #
# Modificacão :     	Rodrigo Alan M. Carvalho			       #
################################################################################


echo "Instalando Temas."

git clone https://github.com/USBA/Deepin-icon-theme.git
mv /Deepin-icon-theme/ /$HOME/.icons
echo "###############################################################"
echo "####                     Reiniciar                         ####"
echo "###############################################################"
