#!/bin/bash
for f in *.svg; do rsvg-convert $f -w 20 -h 20 -f svg -o 24/$f; done

echo Pronto
