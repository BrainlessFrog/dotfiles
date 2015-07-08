#!/bin/bash

# Move all types of windows in Bspwm
# Modified from: https://github.com/windelicato/dotfiles/blob/master/scripts/window_move.sh
# Dependencies: Bspwm and Xdo

POSITIVE=false
HORIZONTAL=false
SIZE="20"

err() {
	echo "$1"
	exit 1;
}

usage() {
	echo "usage: bspwm_move [direction]"
	echo
	echo "Options:"
	echo "	 -p, --positive	      - move in positively (right/up)"
	echo "	 -n, --negative       - move in negatively (left/down)"
	echo "	 -x, --xdir           - move in x direction (left/right"
	echo "	 -y, --ydir           - move in y dir (up/down)"
	echo "	 -s                   - number of pixels to move"
	echo "	 -h, --help           - display this"
}

if [[ "$#" -eq 0 ]] ; then
	usage
	exit 1;
fi

for i in "$@"; do
	case "$i" in
		"-p"|"--positive")
			POSITIVE=true
			;;
		"-n"|"--negative")
			POSITIVE=false
			;;
		"-x"|"--xdir")
			HORIZONTAL=true
			;;
		"-y"|"--ydir")
			HORIZONTAL=false
			;;
		"-s")
			SIZE=`echo "$@" | sed 's/.*-s \([0-9]*\).*/\1/'`
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

# Find current window mode
WINDOW_STATUS=`bspc query -T -w | awk '/^.* [a-zA-Z\-]{8} \*$/{print $8}'`
FLAGS=`echo "$WINDOW_STATUS" | sed 's/-//g'`

if [[ "$FLAGS" =~ ^.*f.*$ ]]; then
# The window is floating, move it
	$HORIZONTAL && switch="-x" || switch="-y"
	$POSITIVE && sign="+" || sign="-"
	xdo move ${switch} ${sign}${SIZE}
else
    # The window is (pseudo)tiled, move it into the preselection, or swap it 
	$HORIZONTAL && switch=("right" "left") || switch=("down" "up")
    $POSITIVE && sign="0" || sign="1"
    bspc window -w ${switch[${sign}]}.manual || bspc window -s ${switch[${sign}]}
fi
