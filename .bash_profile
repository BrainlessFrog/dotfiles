# ~/.bash_profile
# By BrainlessFrog

[[ -f "$HOME/.bashrc" ]] && source "$HOME/.bashrc"

# Autostart X unless a key is pressed
if [[ -z "$DISPLAY" && "$XDG_VTNR" -eq 1 ]]; then
    read -t 3 -N 1 -p "Autostarting X in 3 secondes, press any key to stop ..."
    if [[ ! -z "$REPLY" ]]; then
        echo -e "\nStartx stopped.\n"
    else
        echo -e "\nStarting X ...\n"
        exec startx
    fi
fi
