#!/bin/bash
# Backup and symlink dotfiles
# By BrainlessFrog
# Modified from: https://github.com/mplacona/dotfiles/blob/master/bootstrap.sh

OLDIFS="$IFS"
IFS="
"

dotDir="$HOME/dotfiles"
backDir="$HOME/dotfiles_old/"
currentDate=`date "+%Y-%m-%d"`

filesList="
.bash_profile
.bashrc
.colors
.config/bspwm
.config/compton.conf
.config/dunst
.config/sxhkd
.conky
.conkyrc_desktop
.conkyrc_laptop
.local/share/nemo/scripts
.moc/config
.profile
.scripts
.stalonetrayrc
.tmux.conf
.vim/colors
.vim/filetype.vim
.vim/ftdetect
.vim/spell
.vim/syntax
.vim/templates
.vimperator/colors
.vimperatorrc
.vimrc
.xinitrc
.Xresources
.xscreensaver
"
 
# Create the backup directory
echo "Creating ${backDir}/${currentDate} to backup any existing dotfiles ..."
mkdir -p "${backDir}/${currentDate}"
echo "... done."
echo ""

# Verify if .config exist, if not create it
if [[ ! -d "$HOME/.config" ]]; then
    echo "Creating .config ..."
    mkdir -p "$HOME/.config"
    echo "... done."
    echo ""
fi

# Verify if .local/share/nemo exist, if not create it
if [[ ! -d "$HOME/.local/share/nemo" ]]; then
    echo "Creating .local/share/nemo ..."
    mkdir -p "$HOME/.local/share/nemo"
    echo "... done."
    echo ""
fi

# Verify if .moc exist, if not create it
if [[ ! -d "$HOME/.moc" ]]; then
    echo "Creating .moc ..."
    mkdir -p "$HOME/.moc"
    echo "... done."
    echo ""
fi

# Verify if .vim and its subfolders exists, if not create them
# Install Vundle
VUNDLE=false
if [[ ! -d "$HOME/.vim" ]]; then
    echo "Creating .vim ..."
    mkdir -p "$HOME/.vim"
    echo "... done."
    echo ""

    echo "Creating .vim/backup ..."
    mkdir -p "$HOME/.vim/backup"
    echo "... done."
    echo ""

    echo "Creating .vim/bundle ..."
    mkdir -p "$HOME/.vim/bundle"
    echo "... done."
    echo ""
    
    echo "Installing Vundle ..."
    git clone "https://github.com/gmarik/Vundle.vim.git" "$HOME/.vim/bundle/Vundle.vim" && VUNDLE=true
    echo "... done."
    echo ""
else
    if [[ ! -d "$HOME/.vim/backup" ]]; then
        echo "Creating .vim/backup ..."
        mkdir -p "$HOME/.vim/backup"
        echo "... done."
        echo ""
    fi

    if [[ ! -d "$HOME/.vim/bundle" ]]; then
        echo "Creating .vim/bundle ..."
        mkdir -p "$HOME/.vim/bundle"
        echo "... done."
        echo ""
    
        echo "Installing Vundle ..."
        git clone "https://github.com/gmarik/Vundle.vim.git" "$HOME/.vim/bundle/Vundle.vim" && VUNDLE=true
        echo "... done."
    else
        if [[ ! -f "$HOME/.vim/bundle/Vundle.vim" ]]; then
            echo "Installing Vundle ..."
            git clone "https://github.com/gmarik/Vundle.vim.git" "$HOME/.vim/bundle/Vundle.vim" && VUNDLE=true
            echo "... done."
        fi
    fi
fi

# Verify if .vimperator exist, if not create it
if [[ ! -d "$HOME/.vimperator" ]]; then
    echo "Creating .vimperator ..."
    mkdir -p "$HOME/.vimperator"
    echo "... done."
    echo ""
fi
 
# Change to the dotfiles directory
echo "Changing to the $dotDir directory ..."
cd "$dotDir"
echo "... done."
echo ""
 
# Backup existing dotfiles and symlink others
for file in $filesList; do
    if [[ -L "${HOME}/${file}" ]]; then
        echo "Removing $file previous symlink ..."
        rm ${HOME}/${file}
        echo "... done."
        echo ""
    elif [[ -e "${HOME}/${file}" ]]; then
        echo "Backing $file up ..."
        mkdir -p "${backDir}/${currentDate}/${file%/*}"
        mv "${HOME}/${file}" "${backDir}/${currentDate}/${file}"
        echo "... done."
        echo ""
    fi

    echo "Symlink $file ..."
    ln -s "${dotDir}/${file}" "${HOME}/${file}"
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

# Installing vim plugins
if [[ "$VUNDLE" == "true" ]]; then
    read -p "Do you want to install vim plugins? (Y/n): " vimPlug
    if [[ "$vimPlug" != "n" ]]; then
        echo "Installing vim plugins ..."
        vim +PluginInstall +qall
        echo "... done."
        echo ""
    fi
fi

IFS="$OLDIFS"
