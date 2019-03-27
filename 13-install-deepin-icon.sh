#!/bin/bash
set -e
################################################################################
# Author	:	Erik Dubois					       #
# Modificacão :     	Rodrigo Alan M. Carvalho			       #
################################################################################


echo "Instalando Temas."

git clone https://github.com/USBA/Deepin-icon-theme.git
cd Qogir-theme
./Install -s
echo "###############################################################"
echo "####                     Reiniciar                         ####"
echo "###############################################################"
