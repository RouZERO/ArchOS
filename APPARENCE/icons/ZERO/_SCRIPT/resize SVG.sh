#!/bin/bash
for f in *.svg; do rsvg-convert $f -w 128 -h 128 -f svg -o 128/$f; done
for f in *.svg; do rsvg-convert $f -w 64 -h 64 -f svg -o 64/$f; done
for f in *.svg; do rsvg-convert $f -w 48 -h 48 -f svg -o 48/$f; done
for f in *.svg; do rsvg-convert $f -w 32 -h 32 -f svg -o 32/$f; done
for f in *.svg; do rsvg-convert $f -w 24 -h 24 -f svg -o 24/$f; done
for f in *.svg; do rsvg-convert $f -w 22 -h 22 -f svg -o 22/$f; done
for f in *.svg; do rsvg-convert $f -w 16 -h 16 -f svg -o 16/$f; done
