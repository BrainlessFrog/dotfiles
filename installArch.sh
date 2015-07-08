#!/bin/bash
# Install Archlinux packages
# By BrainlessFrog

packetsList=""

# Pacman only packages
xorg="xorg-server xorg-server-utils xorg-apps xorg-xinit"
nvidia="nvidia nvidia-libgl lib32-nvidia-libgl"
pulseaudio="alsa-utils pulseaudio pavucontrol lib32-alsa-plugins paprefs pulseaudio-alsa lib32-libpulse"
thunderbird="thunderbird thunderbird-i18n-fr"

# (Pacmon +) Aur packages
bspwm="bspwm-git sxhkd-git xdo-git lemonbar-git terminus stlarch_font compton-git dunst stalonetray conky-lua-nv rxvt-unicode dmenu2-hg"
nemo="nemo file-roller nemo-fileroller unrar rar tumbler poppler-glib ffmpegthumbnailer freetype1 libgsf raw-thumbnailer gvfs gvfs-afc ntfs-3g"
lxappearance="lxappearance qtconfiguration awoken-icons gtk-theme-flatstudio xscreensaver-arch-logo nitrogen xcursor-vanilla-dmz"
firefox="firefox firefox-i18n-fr flashplugin ttf-ms-fonts"
