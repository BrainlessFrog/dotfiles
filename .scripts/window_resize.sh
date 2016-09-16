#!/bin/bash
# Resize all types of windows in Bspwm
# By BrainlessFrog

# Dependencies: Bspwm and Xdo

POSITIVE=false
HORIZONTAL=false
SIZE="20"

err() {
	echo "$1"
	exit 1;
}

usage() {
	echo "usage: bspwm_resize [direction]"
	echo
	echo "Options:"
	echo "	 -p, --positive	      - resize in positively"
	echo "	 -n, --negative       - resize in negatively"
	echo "	 -x, --xdir           - resize in x direction"
	echo "	 -y, --ydir           - resize in y dir"
	echo "	 -s, --size [px]      - number of pixels to resize"
	echo "	 -h, --help           - display this"
}

if [[ "$#" -eq 0 ]] ; then
	usage
	exit 1;
fi

ARGS=`getopt -o pnxys:h \
             -l positive,negative,xdir,ydir,size:,help \
             -n "$0" \
             -- "$@"`

eval set -- "$ARGS"

while true; do
	case "$1" in
		"-p"|"--positive")
			POSITIVE=true
            shift
			;;
		"-n"|"--negative")
			POSITIVE=false
            shift
			;;
		"-x"|"--xdir")
			HORIZONTAL=true
            shift
			;;
		"-y"|"--ydir")
			HORIZONTAL=false
            shift
			;;
		"-s"|"--size")
			SIZE="$2"
			if [[ -z `echo "$SIZE" | sed -e "s#[0-9]##g"` ]]; then
                shift 2
            else
                err "Wrong argument! Use either 'half' or a number of pixels"
            fi
			;;
		""|"-h"|"--help")
			usage
			exit 0;
			;;
        --)
            shift
            break
            ;;
		*)
            err "Internal error!"
			;;
	esac
done

# Find current window mode
WINDOW_STATUS=`bspc query -T -n | awk '/^.* [a-zA-Z\-]{8} \*$/{print $8}'`
FLAGS=`echo "$WINDOW_STATUS" | sed 's/-//g'`

if [[ "$FLAGS" =~ ^.*f.*$ ]]; then
# The window is floating, resize it
    $HORIZONTAL && switch=("-w" "-x") || switch=("-h" "-y")
    $POSITIVE && sign=("+" "-") || sign=("-" "+")
    xdo resize ${switch[0]} ${sign[0]}${SIZE} && xdo move ${switch[1]} ${sign[1]}$((SIZE/2))
elif [[ "$FLAGS" =~ ^.*d.*$ ]]; then
# The window is pseudotiled, resize it
	$HORIZONTAL && switch="-w" || switch="-h"
	$POSITIVE && sign="+" || sign="-"
	xdo resize ${switch} ${sign}${SIZE}
else
# The window is tiled, modify the split ratio
	$HORIZONTAL && switch=("left" "right") || switch=("bottom" "down")
	$POSITIVE && sign="+" || sign="-"
    $HORIZONTAL && move="${sign}${SIZE} 0" || move="0 ${sign}${SIZE}"
	bspc node -z ${switch[0]} ${move} ||  bspc node -z ${switch[1]} ${move}
fi
