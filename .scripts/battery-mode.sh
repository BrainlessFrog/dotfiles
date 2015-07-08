#!/bin/bash
#Script de changement de la fréquence du CPU / Mode batterie

if [[ "$#" -ne 1 ]]; then
    echo "Erreur ! Nombre d'argument incorrect !"
    exit 1;
fi

if [[ "$1" == "-s" ]]; then
    gksudo "cpufreq-set -c 0 -g powersave"
    gksudo "cpufreq-set -c 1 -g powersave"
elif [[ "$1" == "-p" ]]; then
    gksudo "cpufreq-set -c 0 -g performance"
    gksudo "cpufreq-set -c 1 -g performance"
else
    echo "Erreur ! Argument invalide !"
    exit 2;
fi

exit 0;
