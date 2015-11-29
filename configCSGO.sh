#!/bin/bash
# Backup and copy CSGO config files
# Steam doesn't like symlinked autoexec -_-
# By BrainlessFrog
# Modified from: https://github.com/mplacona/dotfiles/blob/master/bootstrap.sh

#TODO: correct folder saving

OLDIFS="$IFS"
IFS="
"

dotDir="$HOME/dotfiles"
backDir="$HOME/dotfiles_old"
currentDate=`date "+%Y-%m-%d"`

filesList="
.local/share/Steam/steamapps/common/Counter-Strike Global Offensive/csgo/cfg/autoexec.cfg
.local/share/Steam/steamapps/common/Counter-Strike Global Offensive/csgo/cfg/bottrain.cfg
.local/share/Steam/steamapps/common/Counter-Strike Global Offensive/csgo/cfg/linux.cfg
.local/share/Steam/steamapps/common/Counter-Strike Global Offensive/csgo/cfg/moviemaking.cfg
.local/share/Steam/steamapps/common/Counter-Strike Global Offensive/csgo/cfg/spraynnades.cfg
.local/share/Steam/steamapps/common/Counter-Strike Global Offensive/csgo/cfg/video.txt
"
 
# Create the backup directory
echo "Creating ${backDir}/${currentDate} to backup any existing dotfiles ..."
mkdir -p "${backDir}/${currentDate}"
echo "... done."
echo ""
 
# Change to the dotfiles directory
echo "Changing to the $dotDir directory ..."
cd "$dotDir"
echo "... done."
echo ""
 
# Backup existing dotfiles and symlink others
for file in $filesList; do
    if [[ -e "${HOME}/${file}" ]]; then
        echo "Backing $file up ..."
        mv "${HOME}/${file}" "${backDir}/${currentDate}/${file}"
        echo "... done."
        echo ""
    fi
    echo "Copying $file ..."
    cp "${dotDir}/${file}" "${HOME}/${file}"
    echo "... done."
    echo ""
done

# Cleaning unused directories
if [[ ! `ls -A ${backDir}/${currentDate}` ]]; then
    echo "Removing empty directory ${backDir}/${currentDate} ..."
    rm -r ${backDir}/${currentDate}
    echo "... done."
    echo ""

    if [[ ! `ls -A $backDir` ]]; then
        echo "Removing empty directory $backDir ..."
        rm -r $backDir
        echo "... done."
        echo ""
    fi
fi

IFS="$OLDIFS"
