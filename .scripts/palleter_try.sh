#!/bin/bash
# takes an image and creates a color palette from it
# which gets echoed to the console.
#
# made by rhowaldt (fuck you)
#
# depends: imagemagick

PALETTE=$(convert "$1" -colors 16 -format "%c" histogram:info:)
HEXLIST=$(echo "$PALETTE" | sed 's/^.*\#\(.*\) srgb.*/\1/g')
COL=("0" "8" "1" "9" "2" "A" "3" "B" "4" "C" "5" "D" "6" "E" "7" "F");
LORS=("00;30m" "01;30m" "00;31m" "01;31m" "00;32m" "01;32m" "00;33m" "01;33m" "00;34m" "01;34m" "00;35m" "01;35m" "00;36m" "01;36m" "00;37m" "01;37m")
x=0

while read line; do
      echo -en "\e]P${COL[$x]}$line";
      echo -e "\[\e[${LORS[$x]}\]$line";
      let x=x+1
done <<< "$HEXLIST"
#clear
