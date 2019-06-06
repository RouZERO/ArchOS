#!/bin/bash
set -e
################################################################################
# Author	:	Erik Dubois					       #
# Modificacão :     	Rodrigo Alan M. Carvalho			       #
################################################################################


echo "Limpeza de Pacotes."

sudo pacman -Rns $(pacman -Qtdq)

echo "Limpeza Completa"
