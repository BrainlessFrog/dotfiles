#!/bin/bash
# Backup dotfiles

OLDIFS="$IFS"
IFS="
"

cd $HOME/

filesList="
.bash_aliases
.bash_profile
.bashrc
.colors/
.config/bspwm/
.config/compton.conf
.config/dunst/dunstrc
.config/sxhkd/sxhkdrc
.conky/
.conkyrc_desktop
.conkyrc_laptop
.fonts/
.gnome2/nemo-scripts/
.icons/
.moc/config
moniptables
.profile
rootBashrc
.scripts/
.stalonetrayrc
.themes/
.tmux.conf
.vim/
.vimperator/
.vimperatorrc
.vimrc
.xinitrc
Xmodmap.txt
.Xresources
.xscreensaver
test save.txt
"

excludeList="
--exclude=.vim/backup/*
--exclude=.vimperator/info/*
"

backupName="dotfiles_$(date +%Y-%m-%d).tar.gz"

prettyFilesList=""
for file in $filesList; do
    [[ -f "$file" ]] && prettyFilesList="$prettyFilesList \"$file\""
done

prettyExcludelist=""
for file in $excludeList; do
    [[ -f "$file" ]] && prettyExcludeList="$prettyExcludeList --exclude=\"$file\""
done

[[ -f "$backupName" ]] && rm "$backupName"

#tar -cvpzf "$backupName" `echo "$prettyExcludeList"` `echo "$prettyFilesList"`
tar -cvpzf "$backupName" $excludeList $filesList

IFS="$OLDIFS"
