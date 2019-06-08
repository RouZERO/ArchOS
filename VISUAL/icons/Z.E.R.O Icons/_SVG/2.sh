#!/bin/bash
for f in epicB.svg; do rsvg-convert $f -w 512 -h 512 -f svg -o 512/$f; done

echo Pronto
