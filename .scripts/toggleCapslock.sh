#!/bin/bash

escCode=`xmodmap -pke | grep -e 'Escape' | awk '{print $2}'`
escKey=`xmodmap -pke | grep -e 'Escape' | cut -d '=' -f 2 | sed -e 's/^.//g'`
capsCode=`xmodmap -pke | grep -e 'Caps_Lock' | awk '{print $2}'`
capsKey=`xmodmap -pke | grep -e 'Caps_Lock' | cut -d '=' -f 2 | sed -e 's/^.//g'`

xmodmap -e 'clear Lock' -e "keycode $capsCode = $escKey" -e "keycode $escCode = $capsKey"

