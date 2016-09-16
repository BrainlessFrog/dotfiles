#!/bin/bash
# plugMonitor.sh
# By BrainlessFrog

# Dependencies: xrandr

internalDisplay="eDP1"
externalDisplay="HDMI1"
globalWidth="1024"
globalHeight="768"

PLUG=true
CLONE=true
SCALE=true
AUTO=false
RIGHT=true

err() {
    echo "$1"
    exit 1;
}

usage() {
    echo "plugMonitor [method]"
    echo
    echo "Options:"
    echo "    -c, --clone [scale, auto, geometry]      - clone screen"
    echo "    -e, --expand [right, left]               - expand screen to the side"
    echo "    -i, --internal [display]                 - internal display"
    echo "    -o, --external [display]                 - external display"
    echo "    -u, --unplug                             - unplug external display and reset internal display"
    echo "    -h, --help                               - display this"
}

if [[ "$#" -eq 0 ]]; then
    usage
    exit 1;
fi

ARGS=`getopt -o c:e:i:o:uh \
             -l clone:,expand:,internal:,external:,unplug,help \
             -n "$0" \
             -- "$@"`

eval set -- "$ARGS"

while true; do
    case "$1" in
        "-c"|"--clone")
            PLUG=true
            CLONE=true
            if [[ "$2" == "scale" ]]; then
                SCALE=true
                shift 2
            else
                SCALE=false
                if [[ "$2" == "auto" ]]; then
                    AUTO=true
                    shift 2
                else
                    AUTO=false
                    globalWidth=`echo "$2" | cut -d "x" -f 1`
                    globalHeight=`echo "$2" | cut -d "x" -f 2`
                    if [[ -z `echo "$globalWidth" | sed -e "s#[0-9]##g"` ]] && [[ -z `echo "$globalHeight" | sed -e "s#[0-9]##g"` ]]; then
                        shift 2
                    else
                        err "$2: Wrong argument!"
                    fi
                fi
            fi
            ;;
        "-e"|"--expand")
            PLUG=true
            CLONE=false
            case "$2" in
                "right")
                    RIGHT=true
                    shift 2
                    ;;
                "left")
                    RIGHT=false
                    shift 2
                    ;;
                *)
                    err "$2: Wrong argument!"
                    ;;
            esac
            ;;
        "-i"|"--internal")
            internalDisplay="$2"
            shift 2
            ;;
        "-o"|"--external")
            externalDisplay="$2"
            shift 2
            ;;
        "-u"|"--unplug")
            PLUG=false
            shift
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

if [[ "$PLUG" == "true" ]]; then
    if [[ "$CLONE" == "true" ]]; then
        if [[ "$SCALE" == "true" ]]; then
            internalWidth=`xrandr -q | grep -A 1 "$internalDisplay" | tail -n 1 | awk '{print $1}' | cut -d "x" -f 1`
            internalHeight=`xrandr -q | grep -A 1 "$internalDisplay" | tail -n 1 | awk '{print $1}' | cut -d "x" -f 2`
            externalWidth=`xrandr -q | grep -A 1 "$externalDisplay" | tail -n 1 | awk '{print $1}' | cut -d "x" -f 1`
            externalHeight=`xrandr -q | grep -A 1 "$externalDisplay" | tail -n 1 | awk '{print $1}' | cut -d "x" -f 2`
    
            if [[ "$internalWidth" -lt "$externalWidth" ]]; then
                scaleWidth="0.$((1000 * internalWidth / externalWidth))"
            else
                scaleWidth="1.$((1000 * externalWidth / internalWidth - 1000))"
            fi
    
            if [[ "$internalHeight" -lt "$externalHeight" ]]; then
                scaleHeight="0.$((1000 * internalHeight / externalHeight))"
            else
                scaleHeight="1.$((1000 * externalHeight / internalHeight - 1000))"
            fi
    
            xrandr --output "$externalDisplay" --auto --same-as "$internalDisplay" --scale "$scaleWidth"x"$scaleHeight"
        else
            if [[ "$AUTO" == "true" ]]; then
                globalWidth=`xrandr -q | awk '{print $1}' | uniq -d | head -n 1 | cut -d "x" -f 1`
                globalHeight=`xrandr -q | awk '{print $1}' | uniq -d | head -n 1 | cut -d "x" -f 2`
            fi

            xrandr --output "$internalDisplay" --mode "$globalWidth"x"$globalHeight" --output "$externalDisplay" --mode "$globalWidth"x"$globalHeight" --same-as "$internalDisplay"
        fi
    else
        if [[ "$RIGHT" == "true" ]]; then
            xrandr --output "$externalDisplay" --auto --right-of "$internalDisplay"
        else
            xrandr --output "$externalDisplay" --auto --left-of "$internalDisplay"
        fi
    fi
else
    xrandr --output "$internalDisplay" --auto --output "$externalDisplay" --off
fi
