#!/bin/bash
# Takes an image and creates a color palette from it
# Require imagemagick

PALETTE=$(convert "$1" -colors 16 -format "%c" histogram:info:)
HEXLIST=$(echo "$PALETTE" | sed 's/^.*\#\(.*\) srgb.*/\1/g')
COL=("0" "8" "1" "9" "2" "A" "3" "B" "4" "C" "5" "D" "6" "E" "7" "F");

for i in `seq 0 15`; do
    echo ""
done
