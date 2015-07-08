#!/bin/bash
#Record desktop and audio with ffmpeg

jour=`date +%F`
heure=`date +%F_%H-%M-%S`
screenWidth=`xrandr -q | grep 'Screen' | awk '{print $8}'`
screenHeight=`xrandr -q | grep 'Screen' | awk '{print $10}' | cut -d ',' -f 1`

if [[ -f "/home/$USER/Vidéos/VLC/$jour.mp4" ]]; then
    ffmpeg -video_size ${screenWidth}x${screenHeight} -framerate 30 -f x11grab -i :0.0+0,0 -f pulse -ac 2 -i default "/home/$USER/Vidéos/VLC/$heure.mkv"
else
    ffmpeg -video_size ${screenWidth}x${screenHeight} -framerate 30 -f x11grab -i :0.0+0,0 -f pulse -ac 2 -i default "/home/$USER/Vidéos/VLC/$jour.mkv"
fi

exit 0;
