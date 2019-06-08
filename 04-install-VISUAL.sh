 #!/bin/bash
set -e
################################################################################
# Author	:	Erik Dubois					       #
# Modicificacão :       Rodrigo Alan M. Carvalho			       #
################################################################################


echo "################################################################"
echo "####        Intalando Fontes, Icones e Temas                ####"
echo "################################################################"

#[ -d $HOME"/.fonts" ] || mkdir -p $HOME"/.fonts"
[ -d $HOME"/.icons" ] || mkdir -p $HOME"/.icons"
[ -d $HOME"/.themes" ] || mkdir -p $HOME"/.themes"

#cp -R VISUAL/fonts/* ~/.fonts/
cp -R VISUAL/icons/* ~/.icons/
cp -R VISIUAL/themes/* ~/.themes/

echo "Building new fonts into the cache files";
echo "Depending on the number of fonts, this may take a while..."
#fc-cache -fv ~/.fonts

echo "################################################################"
echo "####     Fonts from Arch Linux repo have been installed     ####"
echo "################################################################"
