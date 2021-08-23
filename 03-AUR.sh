
#!/bin/bash
set -e

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -S pamac-all
