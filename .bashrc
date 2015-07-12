# Sourcing other files
[[ -f "$HOME/.bash_aliases" ]] && source "$HOME/.bash_aliases"
[[ -f "/etc/bash_completion" ]] && source "/etc/bash_completion"
[[ -f "/usr/share/git/completion/git-prompt.sh" ]] && source "/usr/share/git/completion/git-prompt.sh"

# History
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTCONTROL=ignoreboth
shopt -s histappend

# Windows size
shopt -s checkwinsize

# Extended globbing
shopt -s extglob

# Color Prompt
set_prompt () {
    # Initiliazing variables
    local lastCommand="$?"
    local prompType="$1"
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
    [[ $lastCommand -eq 0 ]] && local lastReturn=("$goodResult" "${fgGreenBold}V" "$fgGreenDef" "$bgGreen") || local lastReturn=("$badResult" "${fgRedBold}X" "$fgRedDef" "$bgRed")

    # Git
    [[ -z "$(__git_ps1 '%s')" ]] && local gitColor=("" "" "") || local gitColor=("$fgRedBold" "$fgRedDef" "$bgRed")

    # Setting PS1
    # Foreground color must come before background color
    case "$prompType" in
        "-1a")
            local gitBranch="$(__git_ps1 ' %s')"
            PS1="${resetColors}${fgWhiteBold}${lastCommand} ${lastReturn[1]} ${resetColors}${userColor[0]}\u@\h${resetColors}:${fgBlueBold}\w${gitColor[0]}${gitBranch}${resetColors}\$ "
            ;;
        "-1b")
            local gitBranch="$(__git_ps1 ' %s')"
            PS1="${resetColors}${fgWhiteBold}${lastCommand} ${lastReturn[0]} ${resetColors}${userColor[0]}\u@\h${resetColors}:${fgBlueBold}\w${gitColor[0]}${gitBranch}${resetColors}\$ "
            ;;
        "-2a")
            local gitBranch="$(__git_ps1 ' [%s]')"
            PS1="\n${altChar}l${defChar}[${fgWhiteBold}${lastCommand}${resetColors}]${altChar}q${defChar}[${lastReturn[0]}${resetColors}]${altChar}q${defChar}[${userColor[0]}\u@\h${resetColors}]:[${fgBlueBold}\w${gitColor[0]}${gitBranch}${resetColors}]\n${altChar}mq${defChar}${endLine}${resetColors} "
            ;;
        "-2b")
            local gitBranch="$(__git_ps1 ' %s')"
            PS1="\n${altChar}lu${defChar}${fgWhiteBold}${lastCommand}${resetColors}${altChar}tqu${defChar}${lastReturn[0]}${resetColors}${altChar}tqu${defChar}${userColor[0]}\u@\h${resetColors}${altChar}t${defChar}${endLine}${fgBlueBold} \w${gitColor[0]}${gitBranch}${resetColors}\n${altChar}mq${defChar}${endLine}${resetColors} "
            ;;
        "-p")
            local gitBranch="$(__git_ps1 ' %s')"
            [[ -z "$gitBranch" ]] && local gitPowerline="" || local gitPowerline="${fgWhiteBold}${gitBranch} ${gitColor[1]}${separatorRight}"
            PS1="${resetColors}${fgWhiteBold}${lastReturn[3]} ${lastCommand} ${lastReturn[2]}${userColor[2]}${separatorRight}${fgWhiteBold} \u ${userColor[1]}${bgYellow}${separatorRight}${fgWhiteBold} \h ${fgYellowDef}${bgBlue}${separatorRight}${fgWhiteBold} \w ${fgBlueDef}${gitColor[2]}${separatorRight}${gitPowerline}${resetColors} "
            ;;
        *)
            PS1="${resetColors}${userColor[0]}\u@\h${resetColors}:${fgBlueBold}\w${resetColors}\$ "
            ;;
    esac
}
if [[ "$-" =~ i ]]; then
    PROMPT_COMMAND='set_prompt -p'
else
    PROMPT_COMMAND='set_prompt -1a'
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
alias .....='cd ../../../..'

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
alias grm='git rm'
alias gupdate='git add . && git commit -m "Global update $(date +%F)" && git push origin master'

# Other aliases
alias pweb='ping -c 5 -i 3 195.238.2.21'
alias mvlc='cvlc --no-video'

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
export VISUAL="/usr/bin/vim"

# CSGO
#export SDL_VIDEO_X11_MOUSEACCEL="1/1/0"
#export SDL_VIDEO_X11_DGAMOUSE="0"
#export SDL_MOUSE_RELATIVE="0"
