#!/bin/bash
set -e

cd /tmp/
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -S pamac-all
