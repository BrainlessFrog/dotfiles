#!/bin/bash
# Install Archlinux packages
# By BrainlessFrog

# TODO: finish it...

# Initialize variable
packetsList=""

# Base packages
base="vim tmux bash-completion ntp"

# Xorg dependent packages
xorg="xorg-server xorg-server-utils xorg-apps xorg-xinit"
nvidia="nvidia nvidia-libgl lib32-nvidia-libgl"
pulseaudio="alsa-utils pulseaudio pavucontrol lib32-alsa-plugins paprefs pulseaudio-alsa lib32-libpulse"

bspwm="bspwm-git sxhkd-git xdo-git lemonbar-git terminus stlarch_font compton-git dunst stalonetray conky-lua-nv rxvt-unicode dmenu2-hg lm_sensors hddtemp glipper numlockx"
lxappearance="lxappearance qtconfiguration awoken-icons gtk-theme-flatstudio xscreensaver-arch-logo nitrogen xcursor-vanilla-dmz"
fonts="ttf-dejavu powerline-fonts-git ttf-droid"

nemo="nemo file-roller nemo-fileroller unrar rar tumbler poppler-glib ffmpegthumbnailer freetype1 libgsf raw-thumbnailer gvfs gvfs-afc ntfs-3g"
files="vlc geany gpicview gcolor2 exfalso mupdf"
firefox="firefox firefox-i18n-fr flashplugin ttf-ms-fonts"
thunderbird="thunderbird thunderbird-i18n-fr"
libreoffice="libreoffice-fresh hunspell hunspell-fr"
conv="skype mumble"
steam="steam steam-fonts"
jdowloader="jre8-openjdk jdownloader2"
terminal="moc zenity scrot screenfetch-git mps-youtube livestreamer htop"
wine="wine wine_gecko wine-mono playonlinux samba lib32-libxml2"

webcam="guvcview"
printer="cups cups-pdf ghostscript gsfonts hplip system-config-printer"
razer="razercfg-git python-pyside evhz-git"
wifi=""

# Choise packages


# Add archlinuxfr repo (required for an easier yaourt install)
sudo echo '' >> /etc/pacman.conf
sudo echo '[archlinuxfr]' >> /etc/pacman.conf
sudo echo 'SigLevel = Never' >> /etc/pacman.conf
sudo echo 'Server = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf

# Install yaourt
sudo pacman -Sy
sudo pacman -S yaourt

# Update all packages
yaourt -Syyua

# Install packages
yaourt -S "$packetsList"
