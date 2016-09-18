#!/bin/sh
# ~/.xinitrc
# By BrainlessFrog

# Export GKT2 var for QtConfig
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Export Java var
export _JAVA_AWT_WM_NONREPARENTING="1"
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

#Make Pulseaudio not overwritte ALSA settings
#restore_alsa() {
#    while [ -z "`pidof pulseaudio`" ]; do
#        sleep 0.5
#    done
#    alsactl -f /var/lib/alsa/asound.state restore 
#}
#restore_alsa &

# Redefine PATH
export PATH="$PATH:$HOME/.scripts:$HOME/.config/bspwm"

[[ `echo "$HOSTNAME" | grep "desktop"` ]] && DESKTOP=true || DESKTOP=false

# Fonts
setDesktopFonts() {
    xset +fp /usr/share/fonts/local
    xset +fp /usr/share/fonts/misc
    xset +fp /usr/share/fonts/OTF
    xset +fp /usr/share/fonts/steam-fonts
    xset +fp /usr/share/fonts/TTF
    xset +fp $HOME/.fonts
    xset fp rehash
}

setLaptopFonts() {
    xset +fp /usr/share/fonts/local
    xset +fp /usr/share/fonts/truetype
    xset +fp /usr/share/fonts/truetype/abyssinica
    xset +fp /usr/share/fonts/truetype/dejavu
    xset +fp /usr/share/fonts/truetype/droid
    xset +fp /usr/share/fonts/truetype/freefont
    xset +fp /usr/share/fonts/truetype/kacst
    xset +fp /usr/share/fonts/truetype/kacst-one
    xset +fp /usr/share/fonts/truetype/lao
    xset +fp /usr/share/fonts/truetype/liberation
    xset +fp /usr/share/fonts/truetype/msttcorefonts
    xset +fp /usr/share/fonts/truetype/nanum
    xset +fp /usr/share/fonts/truetype/noto
    xset +fp /usr/share/fonts/truetype/openoffice
    xset +fp /usr/share/fonts/truetype/padauk
    xset +fp /usr/share/fonts/truetype/sinhala
    xset +fp /usr/share/fonts/truetype/takao-gothic
    xset +fp /usr/share/fonts/truetype/tibetan-machine
    xset +fp /usr/share/fonts/truetype/tlwg
    xset +fp /usr/share/fonts/truetype/ttf-dejavu
    xset +fp /usr/share/fonts/truetype/ttf-indic-fonts-core
    xset +fp /usr/share/fonts/truetype/ttf-khmeros-core
    xset +fp /usr/share/fonts/truetype/ttf-punjabi-fonts
    xset +fp /usr/share/fonts/truetype/ubuntu-font-family
    xset +fp /usr/share/fonts/truetype/wqy
    xset +fp /usr/share/fonts/type1/gsfonts
    xset +fp /usr/share/fonts/type1/mathml
    xset +fp $HOME/.fonts
    xset fp rehash
}

$DESKTOP && setDesktopFonts || setLaptopFonts

# Load Xresources
[[ -f ~/.Xresources ]] && xrdb -load $HOME/.Xresources
[[ -f ~/.Xdefaults ]] && xrdb -merge $HOME/.Xdefaults

# Systemd
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?* ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# X cursor fix
xsetroot -cursor_name left_ptr

# Pulseaudio
#start-pulseaudio-x11 &

numlockx on &
$DESKTOP && sxhkdConfig="$HOME/.config/sxhkd/desktop.sxhkdrc" || sxhkdConfig="$HOME/.config/sxhkd/laptop.sxhkdrc"
#sxhkd -c "$HOME/.config/sxhkd/base.sxhkdrc" "$sxhkdConfig" &
sxhkd -c "$HOME/.config/sxhkd/base.sxhkdrc" &
urxvtd &

# Ctrl+Alt+Backspace to kill Xorg
setxkbmap -option terminate:ctrl_alt_bksp

exec bspwm
