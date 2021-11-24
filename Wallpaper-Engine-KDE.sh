#!/bin/bash
set -e

cd /tmp/
git clone https://github.com/catsout/wallpaper-engine-kde-plugin.git
cd wallpaper-engine-kde-plugin
mkdir build && cd build
cmake .. -DUSE_PLASMAPKG=ON
make
make install_pkg
sudo make install
