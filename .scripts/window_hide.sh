#!/bin/bash
# Hide and Show windows in Bspwm
# By BrainlessFrog

# Dependencies: Bspwm, Xdo and Dmenu

LOGFILE="/tmp/bspwm_hidden.txt"

err() {
	echo "$1"
	exit 1;
}

usage() {
	echo "usage: bspwm_hide [options]"
	echo
	echo "Options:"
    echo "   hide [id]                        - hide current or specified window"
    echo "   show                             - show window"
    echo "        -a, --all                         all windows"
    echo "        -i, --id                          specified id"
    echo "   list                             - list all hidden windows"
	echo "	      -a, --all     	                print names and id's"
	echo "	      -i, --id      	                print id's only"
	echo "	      -n, --name    	                print names only"
    echo "        -number                           return the number of hidden windows"
    echo "   dmenu [dmenu options]            - select the window to show with a dmenu wrapper"
	echo "	 -h, --help                       - display this"
}

hide() {
    [[ -n "$1" ]] && local winID="$1" || local winID=`xdo id`
    local winName=`xprop -id "$winID" | grep "WM_NAME" | head -n 1 | cut -d '"' -f 2`

    xdo hide -p "$winID"
    echo "$winName;$winID" >> "$LOGFILE"
}

show() {
    local arg="$1"
    case "$arg" in
        "-a"|"--all")
            for winID in `cat "$LOGFILE" | cut -d ';' -f 2`; do
                xdo show "$winID"
                sed -i "/$winID/d" "$LOGFILE"
            done
            ;;
        "-i"|"--id")
            local winID="$2"
            xdo show "$winID"
            sed -i "/$winID/d" "$LOGFILE"
            ;;
        *)
            for winID in `cat "$LOGFILE" | cut -d ';' -f 2`; do
                xdo show "$winID"
                sed -i "/$winID/d" "$LOGFILE"
            done
            ;;
    esac
}

list() {
    local arg="$1"
    if [[ -f "$LOGFILE" ]] && [[ -s "$LOGFILE" ]]; then
        case "$arg" in
            "-a"|"--all")
                local textOut=`cat "$LOGFILE"`
                ;;
            "-i"|"--id")
                local textOut=`cat "$LOGFILE" | cut -d ';' -f 2`
                ;;
            "-n"|"--name")
                local textOut=`cat "$LOGFILE" | cut -d ';' -f 1`
                ;;
            "--number")
                local textOut=`cat "$LOGFILE" | wc -l`
                ;;
            *)
                local textOut=`cat "$LOGFILE"`
                ;;
        esac
    else
        if [[ "$arg" == "--number" ]]; then
            local textOut="0"
        else
            local textOut="No hidden windows"
        fi
    fi

    echo "$textOut"
}

if [[ "$#" -eq 0 ]] ; then
	usage
	exit 1;
fi

dmWrapper() {
    local args="${@}"

    if [[ `list --number` -eq 0 ]]; then
        echo "Error! No hidden windows."
    else
        local windowsList=`list -a | sed = | sed 'N;s/\n/;/'`

        local showWin=`echo -e "$windowsList" | cut -d ';' -f '-2' | sed 's/;/ /g' | dmenu ${args#dmenu *} | cut -d ' ' -f 1`

        show -i `echo "$windowsList" | sed -n ${showWin}p | cut -d ';' -f 3`
    fi
}

case "$1" in
    "hide")
        if [[ -n "$2" ]]; then
            hide "$2"
        else
            hide
        fi
        ;;
    "show")
        case "$2" in
            "-i"|"--id")
                show -i "$3"
                ;;
            *)
                show
                ;;
        esac
        ;;
    "list")
        list "$2"
        ;;
    "dmenu")
        dmWrapper "$@"
        ;;
    ""|"-h"|"--help")
        usage
        exit 0;
        ;;
    *)
        ;;
esac
