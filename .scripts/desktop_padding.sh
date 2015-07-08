#!/bin/bash

# Change the desktop padding in Bspwm
# Dependencies: Bspwm

POSITIVE=false
SIZE="20"
UP=false
DOWN=false
RIGHT=false
LEFT=false
TOGGLE=false
HALF=false

err() {
	echo "$1"
	exit 1;
}

usage() {
	echo "usage: bspwm_desktop-padding [polarity]"
	echo
	echo "Options:"
	echo "	 -a, --all     	                  - change desktop padding of all the sides"
	echo "	 -u, --up      	                  - change desktop padding of the upper side"
	echo "	 -d, --down    	                  - change desktop padding of the lower side"
	echo "	 -r, --right   	                  - change desktop padding of the right side"
	echo "	 -l, --left    	                  - change desktop padding of the left side"
	echo "	 -p, --positive	                  - increase desktop padding"
	echo "	 -n, --negative                   - decrease desktop padding"
	echo "	 -t, --toggle [half, -s]          - toggle desktop padding"
	echo "	 -s                               - number of pixels to move"
	echo "	 -h, --help                       - display this"
}

if [[ "$#" -eq 0 ]] ; then
	usage
	exit 1;
fi

for i in "$@"; do
	case "$i" in
		"-a"|"--all")
            UP=true
            DOWN=true
            RIGHT=true
            LEFT=true
			;;
		"-u"|"--up")
            UP=true
			;;
		"-d"|"--down")
			DOWN=true
			;;
		"-r"|"--right")
			RIGHT=true
			;;
		"-l"|"--left")
			LEFT=true
			;;
		"-p"|"--positive")
			POSITIVE=true
			;;
		"-n"|"--negative")
			POSITIVE=false
			;;
		"-t"|"--toggle")
			TOGGLE=true
			;;
		"half")
			HALF=true
			;;
		"-s")
			SIZE=`echo $@ | sed 's/.*-s \([0-9]*\).*/\1/'`
			[[ "$SIZE" == "$@" ]] && err "Must specify number of pixels"
			;;
		""|"-h"|"--help")
			usage
			exit 0;
			;;
		*)
			;;
	esac
done

# Determine which sides to modify
$UP && sides=("top")
$DOWN && sides=("${sides[@]}" "bottom")
$RIGHT && sides=("${sides[@]}" "right")
$LEFT && sides=("${sides[@]}" "left")

sidesNumber="${#sides[@]}"
for i in `seq 0 $((sidesNumber - 1))`; do
    currentPosition=`bspc config -d focused ${sides[$i]}_padding`

    if [[ "$TOGGLE" == "true" ]]; then
        if [[ "$HALF" == "true" ]]; then
            defTopPadding=`bspc query -T | head -n 1 | awk '{print $3}' | cut -d ',' -f 1`
            defRightPadding=`bspc query -T | head -n 1 | awk '{print $3}' | cut -d ',' -f 2`
            defBottomPadding=`bspc query -T | head -n 1 | awk '{print $3}' | cut -d ',' -f 3`
            defLeftPadding=`bspc query -T | head -n 1 | awk '{print $3}' | cut -d ',' -f 4`

            screenWidth=`xrandr -q | grep 'Screen' | awk '{print $8}'`
            screenHeight=`xrandr -q | grep 'Screen' | awk '{print $10}' | cut -d ',' -f 1`
            
            windowGap=`bspc config -d focused window_gap`

            case "${sides[$i]}" in
                "top"|"bottom")
                    SIZE=$(((screenHeight - defTopPadding - defBottomPadding - windowGap) / 2))
                    ;;
                "right"|"left")
                    SIZE=$(((screenWidth - defRightPadding - defLeftPadding - windowGap) / 2))
                    ;;
                *)
                    ;;
            esac
        fi
        [[ $currentPosition -eq 0 ]] && move="$SIZE" || move="0"
    else
        $POSITIVE && move=$((currentPosition + SIZE)) || move=$((currentPosition - SIZE))
        # Don't go below 0
        [[ $move -lt 0 ]] && move="0"
    fi

    bspc config -d focused ${sides[$i]}_padding $move
done
