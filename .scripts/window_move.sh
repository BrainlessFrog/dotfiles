#!/bin/bash
# Move all types of windows in Bspwm
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
	echo "usage: bspwm_move [direction]"
	echo
	echo "Options:"
	echo "	 -p, --positive	      - move in positively (right/up)"
	echo "	 -n, --negative       - move in negatively (left/down)"
    echo "	 -x, --xdir           - move in x direction (left/right)"
	echo "	 -y, --ydir           - move in y dir (up/down)"
	echo "	 -s, --size [px]      - number of pixels to move"
	echo "	 -h, --help           - display this"
}

if [[ "$#" -eq 0 ]]; then
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
# The window is floating, move it
	#$HORIZONTAL && switch="-x" || switch="-y"
	#$POSITIVE && sign="+" || sign="-"
	#xdo move ${switch} ${sign}${SIZE}
	$POSITIVE && sign="+" || sign="-"
	$HORIZONTAL && move="${sign}${SIZE} 0" || move="0 ${sign}${SIZE}"
    bspc node -v ${move}
else
    # The window is (pseudo)tiled, move it into the preselection, or swap it 
	$HORIZONTAL && switch=("east" "west") || switch=("south" "north")
    $POSITIVE && sign="0" || sign="1"
    bspc node -n ${switch[${sign}]}.!automatic || bspc node -s ${switch[${sign}]}
fi
