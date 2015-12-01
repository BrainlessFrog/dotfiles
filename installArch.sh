#!/bin/bash
# Install Archlinux packages
# By BrainlessFrog

# TODO: test it...

# Initialize variable
packetsList=""
fullInstall=""

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
wifi="broadcom-wl-dkms"
xbacklight="xbacklight"

askPackage() {
    local package="$1"
    local result="Y"
    local reply="true"
    
    read -e -p "Do you want to install the $package package? Y/n " result
    if [[ "$result" == "N" ]] || [[ "$result" == "n" ]]; then
        reply=false
    fi

    echo "$reply"
}

# Choose packages
read -e -p "Would you like to make a complete installation? N/d(esktop)/l(aptop) " fullInstall
if [[ "$fullInstall" == "d" ]] || [[ "$fullInstall" == "desktop" ]]; then
    packetsList="$base $xorg $nvidia $pulseaudio $bspwm $lxappearance $fonts $nemo $files $firefox $thunderbird $libreoffice $conv $steam $jdowloader $terminal $wifi $webcam $printer $razer"
elif [[ "$fullInstall" == "l" ]] || [[ "$fullInstall" == "laptop" ]]; then
    packetsList="$base $xorg $pulseaudio $bspwm $lxappearance $fonts $nemo $files $firefox $thunderbird $libreoffice $conv $steam $jdowloader $terminal $wifi $webcam $printer $wifi $xbacklight"
else
    askPackage base && packetsList="${packetsList}${base} "
    askPackage xorg && packetsList="${packetsList}${xorg} "
    askPackage nvidia && packetsList="${packetsList}${nvidia} "
    askPackage pulseaudio && packetsList="${packetsList}${pulseaudio} "
    askPackage bspwm && packetsList="${packetsList}${bspwm} "
    askPackage lxappearance && packetsList="${packetsList}${lxappearance} "
    askPackage fonts && packetsList="${packetsList}${fonts} "
    askPackage nemo && packetsList="${packetsList}${nemo} "
    askPackage files && packetsList="${packetsList}${files} "
    askPackage firefox && packetsList="${packetsList}${firefox} "
    askPackage thunderbird && packetsList="${packetsList}${thunderbird} "
    askPackage libreoffice && packetsList="${packetsList}${libreoffice} "
    askPackage conv && packetsList="${packetsList}${conv} "
    askPackage steam && packetsList="${packetsList}${steam} "
    askPackage jdowloader && packetsList="${packetsList}${jdowloader} "
    askPackage terminal && packetsList="${packetsList}${terminal} "
    askPackage wine && packetsList="${packetsList}${wine} "
    askPackage webcam && packetsList="${packetsList}${webcam} "
    askPackage printer && packetsList="${packetsList}${printer} "
    askPackage razer && packetsList="${packetsList}${razer} "
    askPackage wifi && packetsList="${packetsList}${wifi} "
    askPackage xbacklight && packetsList="${packetsList}${xbacklight} "
fi

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
yaourt -S $packetsList
