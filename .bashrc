# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Extended globbing
shopt -s extglob

# Color Prompt
set_prompt () {
    # Initiliazing variables
    local lastCommand=$? # Must come first!
    local defChar="\[\017\]"
    local altChar="\[\016\]"

    # Colors
    local fgBlackDef="\[\e[00;30m\]"
    local fgRedDef="\[\e[00;31m\]"
    local fgGreenDef="\[\e[00;32m\]"
    local fgYellowDef="\[\e[00;33m\]"
    local fgBlueDef="\[\e[00;34m\]"
    local fgMagentaDef="\[\e[00;35m\]"
    local fgCyanDef="\[\e[00;36m\]"
    local fgWhiteDef="\[\e[00;37m\]"
    local fgBlackBold="\[\e[01;30m\]"
    local fgRedBold="\[\e[01;31m\]"
    local fgGreenBold="\[\e[01;32m\]"
    local fgYellowBold="\[\e[01;33m\]"
    local fgBlueBold="\[\e[01;34m\]"
    local fgMagentaBold="\[\e[01;35m\]"
    local fgCyanBold="\[\e[01;36m\]"
    local fgWhiteBold="\[\e[01;37m\]"

    local bgBlack="\[\e[40m\]"
    local bgRed="\[\e[41m\]"
    local bgGreen="\[\e[42m\]"
    local bgYellow="\[\e[43m\]"
    local bgBlue="\[\e[44m\]"
    local bgMagenta="\[\e[45m\]"
    local bgCyan="\[\e[46m\]"
    local bgWhite="\[\e[47m\]"

    local resetColors="\[\e[m\]"

    # Unicode characters
    local badResult="${fgRedBold}\342\234\227"
    local goodResult="${fgGreenBold}\342\234\223"
    local endLine="\342\225\274"
    #local separatorRight=""
    #local separatorRight=$'\uE0B0'
    local separatorRight="\356\202\260"
    #local separatorLeft=""
    #local separatorLeft=$'\uE0B2'
    local separatorLeft="\356\202\262"

    # Root?
    [[ $(id -u) -eq 0 ]] && local userColor=("$fgRedBold" "$fgRedDef" "$bgRed") || local userColor=("$fgGreenBold" "$fgGreenDef" "$bgGreen")

    # Last return
    [[ $lastCommand -eq 0 ]] && local lastReturn=("$goodResult" "$fgGreenDef" "$bgGreen") || local lastReturn=("$badResult" "$fgRedDef" "$bgRed")

    # Setting PS1
    # Foreground color must come before background color

    # One line PS1:
    #PS1="${resetColors}${fgWhiteBold}${lastCommand} ${lastReturn[0]} ${resetColors}${userColor[0]}\u@\h${resetColors}:${fgBlueBold}\w${resetColors}\$ "

    #Two lines prompt:
    #PS1="\n${altChar}l${defChar}[${fgWhiteBold}${lastCommand}${resetColors}]${altChar}q${defChar}[${lastReturn}${resetColors}]${altChar}q${defChar}[${userColor[0]}\u@\h${resetColors}]:[${fgBlueBold}\w${resetColors}]\n${altChar}mq${defChar}${endLine}${resetColors} "
    #PS1="\n${altChar}lu${defChar}${fgWhiteBold}${lastCommand}${resetColors}${altChar}tqu${defChar}${lastReturn}${resetColors}${altChar}tqu${defChar}${userColor[0]}\u@\h${resetColors}${altChar}t${defChar}${endLine}${fgBlueBold} \w${resetColors}\n${altChar}mq${defChar}${endLine}${resetColors} "

    # Powerline PS1 (Require Powerline fonts):
    PS1="${resetColors}${fgWhiteBold}${lastReturn[2]} ${lastCommand} ${lastReturn[1]}${userColor[2]}${separatorRight}${fgWhiteBold} \u ${userColor[1]}${bgYellow}${separatorRight}${fgWhiteBold} \h ${fgYellowDef}${bgBlue}${separatorRight}${fgWhiteBold} \w ${fgBlueDef}${separatorRight}${resetColors} "

}
PROMPT_COMMAND='set_prompt'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable color support of ls and also add handy aliases
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Some more ls aliases
alias ll='ls -lAh'
#alias la='ls -A'
#alias l='ls -CF'

# cd aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Avoid -_-
alias exxit='exit'
alias quit='exit'
alias :q='exit'
alias fu='sudo $(fc -n -l -1)'
alias ffs='sudo $(fc -n -l -1)'
alias pls='sudo $(fc -n -l -1)'
alias vmi='vim'

# Shutdown aliases
alias bye='sudo shutdown -h now'
alias cya='sudo shutdown -r now'

# Apt aliases
alias psearch='sudo apt-cache search'
alias pinstall='sudo apt-get install'
alias pupdate='sudo apt-get update'
alias pupgrade='sudo apt-get upgrade'
alias puptot='sudo apt-get update && sudo apt-get upgrade'
alias premove='sudo apt-get remove'
alias paremove='sudo apt-get autoremove'

# Git aliases
alias gadd='git add'
alias gaa='git add .'
alias gcom='git commit -m'
alias gpull='git pull origin master'
alias gpush='git push origin master'
alias gupdate='git add . && git commit -m "Global update $(date +%F)" && git push origin master'

# Other aliases
alias pweb='ping -c 5 -i 3 195.238.2.21'
alias mvlc='cvlc --no-video'

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Enable completion for sudo
complete -cf sudo

# Enable completion for man 
complete -cf man

# Enable cd correction
shopt -s cdspell 

# Use vi like shortcuts
set -o vi

# Export variable
export PATH="$PATH:/home/kevin/.scripts:/home/kevin/.config/bspwm"
export EDITOR="/usr/bin/vim"
#export TERM="screen-256color"
export VISUAL="/usr/bin/vim"

# CSGO
#export SDL_VIDEO_X11_MOUSEACCEL="1/1/0"
#export SDL_VIDEO_X11_DGAMOUSE="0"
#export SDL_MOUSE_RELATIVE="0"
