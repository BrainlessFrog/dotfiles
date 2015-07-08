#!/bin/bash
#Record desktop with VLC

jour=`date +%F`
heure=`date +%F_%H-%M-%S`

if [[ -f "/home/$USER/Vidéos/VLC/$jour.mp4" ]]; then
    vlc screen:// --screen-fps=30 --quiet --sout "#transcode{vcodec=h264,vb072}:standard{access=file,mux=mp4,dst="/home/$USER/Vidéos/VLC/$heure.mp4"}"
else
    vlc screen:// --screen-fps=30 --quiet --sout "#transcode{vcodec=h264,vb072}:standard{access=file,mux=mp4,dst="/home/$USER/Vidéos/VLC/$jour.mp4"}"
fi

exit 0;
