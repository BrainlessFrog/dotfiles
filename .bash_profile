#
# ~/.bash_profile
#

[[ -f "$HOME/.bashrc" ]] && source "$HOME/.bashrc"

PROMPT_COMMAND='set_prompt -1a'

#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
