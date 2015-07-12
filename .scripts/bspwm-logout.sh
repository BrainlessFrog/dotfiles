#!/bin/bash
# Script d'extinction pour Bspwm
# Par BrainlessFrog

# Date de création :              26/12/2014
# Date de dernière modification : 26/12/2014

# Historique des modification :
# * 26/12/2014 : Copie de ob-logout.sh et modification des options


#=======================================================================================================================
#=======================================================================================================================

# Affiche la fenêtre Zenity et demande de faire un choix :
# --------------------------------------------------------

choix=`zenity --list --radiolist --width=240 --height=263 --title="Openbox Logout :" --text="Que voulez-vous faire ?" \
--column="Choix" --column="Numéros" --column="Proposition" \
TRUE 1 "Arrêter le PC" \
FALSE 2 "Redémarrer le PC" \
FALSE 3 "Mettre en veille" \
FALSE 4 "Hiberner" \
FALSE 5 "Vérouiller l'écran" \
FALSE 6 "Fermer la session" \
--hide-column=2 --print-column=2`

# Vérifie si l'un choix a été validé ou si l'utilisateur a annulé, puis applique le choix :
# -----------------------------------------------------------------------------------------

if [[ "$?" -eq 0 ]]; then
    case "$choix" in
        "1")
            # Éteindre
            gksudo "shutdown -h now"
            ;;
        "2")
            # Redémarrer
            gksudo "shutdown -r now"
            ;;
        "3")
            # Mettre en veille
            gksudo "pm-suspend"
            ;;
        "4")
            # Hiberner
            gksudo "pm-hibernate"
            ;;
        "5")
            # Vérouiller l'écran
            xscreensaver-command --lock
            ;;
        "6")
            # Fermer la session
            bspc quit
            ;;
    esac
    exit 0;
else
    exit 1;
fi
