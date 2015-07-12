#!/bin/bash
# Script servant à lister les films et les series du O2.
# Par BrainlessFrog.

# Date de création :                09/04/2010
# Date de dernière modification :   07/03/2015

# Log des modifications :
# 31/08/2011 : Ajout des iso's.
# 05/10/2014 : Ajout des séries.
#              Ajout d'un menu de sélection des fichiers à lister.
# 07/03/2015 : Mise en conformité de la syntaxe du code.
#              Ajout des mp4's pour la partie films.
#              La création des listes est maintenant faite à l'aide d'une fonction.
#              Ajout de variables stockant le chemin d'accès des Films/Séries.
# 10/03/2015 : Détection automatique des dossiers Films/Séries.
#              Vérification de l'existance des dossiers Films/Séries
# 11/03/2015 : Modification des choix possibles suivant l'existance des dossiers Films/Séries
#              Ajout d'une sélection manuelle des dossiers si besoin

# ========================================================================================================================================

# Backup de l'IFS
OLDIFS="$IFS"
IFS="
"

# Path des Films et Série
locationScript=`readlink -f "$(dirname \"$0\")"`
locationFilms=`find "$locationScript" -name "Films"`
locationSeries=`find "$locationScript" -name "Séries"`

# Vérification de l'existence des dossiers
[[ -n "$locationFilms" ]] && FILMS=true || FILMS=false
[[ -n "$locationSeries" ]] && SERIES=true || SERIES=false

# Sélection manuelle si besoin
if [[ "$FILMS" == "false" ]]; then
    zenity --error --title="Films ..." --text="Impossible de trouver le dossier 'Films'.\nVoulez-vous le sélectionner manuellement ?"
    if [[ "$?" -eq 0 ]]; then
        while true; do
            locationFilms=`zenity --file-selection --directory --title="Films ..." --text="Veuillez sélectionner le dossier 'Films'."`
            if [[ "$?" -eq 0 ]]; then
                [[ -n "$locationFilms" ]] && FILMS=true || FILMS=false
                $FILMS && break
            else
                break
            fi
        done
    fi
fi

if [[ "$SERIES" == "false" ]]; then
    zenity --error --title="Séries ..." --text="Impossible de trouver le dossier 'Séries'.\nVoulez-vous le sélectionner manuellement ?"
    if [[ "$?" -eq 0 ]]; then
        while true; do
            locationSeries=`zenity --file-selection --directory --title="Séries ..." --text="Veuillez sélectionner le dossier 'Séries'."`
            if [[ "$?" -eq 0 ]]; then
                [[ -n "$locationSeries" ]] && SERIES=true || SERIES=false
                $SERIES && break
            else
                break
            fi
        done
    fi
fi

# Si il n'y a ni Films, ni Séries, quitter
if [[ "$FILMS" == "false" ]] && [[ "$SERIES" == "false" ]]; then
    zenity --error --title="Erreur !" --text="Aucun dossier Films ou Séries !"
    exit 1;
fi

# Définition des choix possibles - partie  sélection
$SERIES && optionsChoix=("FALSE" "3" "Les séries uniquement")
$FILMS && optionsChoix=("FALSE" "2" "Les films uniquement" "${optionsChoix[@]}")
$FILMS && $SERIES && optionsChoix=("FALSE" "1" "Les films et les séries" "${optionsChoix[@]}")

nombreChoix="${#optionsChoix[@]}"
for i in `seq 0 $((nombreChoix - 1 ))`; do
    if [[ "${optionsChoix[$i]}" == "FALSE" ]]; then
        optionsChoix[$i]="TRUE"
        break
    fi
done

# Définition des choix possibles - partie affichage
optionsAffichage=("TRUE" "4" "Aucun des deux")
$SERIES && optionsAffichage=("FALSE" "3" "Les séries uniquement" "${optionsAffichage[@]}")
$FILMS && optionsAffichage=("FALSE" "2" "Les films uniquement" "${optionsAffichage[@]}")
$FILMS && $SERIES && optionsAffichage=("FALSE" "1" "Les films et les séries" "${optionsAffichage[@]}")

# Création de la liste des films
getMovies() {
    local moviesPath="$1"
    
    # Films en *.avi
    echo "20"; sleep 1
    echo "# Recherche de tous les films en *.avi ..."; sleep 1
    find "$moviesPath" -name "*.avi" > temp_films_avi.txt

    # Films en *.mkv
    echo "30"; sleep 1
    echo "# Recherche de tous les films en *.mkv ..."; sleep 1
    find "$moviesPath" -name "*.mkv" > temp_films_mkv.txt

    # Films en *.iso
    echo "40"; sleep 1
    echo "# Recherche de tous les films en *.iso ..."; sleep 1
    find "$moviesPath" -name "*.iso" > temp_films_iso.txt

    # Films en *.mp4
    echo "50"; sleep 1
    echo "# Recherche de tous les films en *.mp4 ..."; sleep 1
    find "$moviesPath" -name "*.mp4" > temp_films_mp4.txt

    # Mise en commun
    echo "60"; sleep 1
    echo "# Mise en commun des listes de fichiers ..."; sleep 1
    cat temp_films_avi.txt temp_films_mkv.txt temp_films_iso.txt temp_films_mp4.txt > temp_films_list.txt

    # On ne garde que le nom et la catégorie du film
    echo "80"; sleep 1
    echo "# Modification de la liste afin de ne garder que le nom des films et leur genre ..."; sleep 1
    for film in `cat temp_films_list.txt`; do
        local nombreSlash=`echo "$film" | sed -e "s#\/#\n#g" | wc -l`
        local nom=`echo "$film" | cut -d '/' -f $nombreSlash`
        local categorie=`echo "$film" | cut -d '/' -f $((nombreSlash - 2))`

        echo "$nom       (${categorie})" >> temp_films_name.txt
    done

    # Tri par ordre alphabétique
    echo "90"; sleep 1
    echo "# Tri par ordre alphabétique des films ..."; sleep 1
    sort temp_films_name.txt > "Liste des films du O2.txt"

    # Nettoyage
    echo "99"; sleep 1
    echo "# Suppression des fichiers temporaires crées ..."; sleep 1
    rm temp_films_avi.txt temp_films_mkv.txt temp_films_iso.txt temp_films_mp4.txt temp_films_list.txt temp_films_name.txt
    chmod -x "Liste des films du O2.txt"
}

getSeries() {
    local seriesPath="$1"

    # Liste de séries
    echo "25"; sleep 1
    echo "# Recherche de toutes les séries présentes sur l'O2 ..."; sleep 1
    find "$seriesPath" -mindepth 2 -maxdepth 2 -type d > temp_series_list.txt 

    # On ne garde que les noms et on ajoute le nombre de saisons ainsi que le nombre d'épisodes dans la dernière saison
    echo "50"; sleep 1
    echo "# Modification de la liste afin de ne garder que le nom des séries, le nombre de saisons, et le nombre d'épisodes de la dernière saison ..."; sleep 1
    for serie in `cat temp_series_list.txt`; do
        local nombreSlash=`echo "$serie" | sed -e "s#\/#\n#g" | wc -l`
        nom=`echo "$serie" | cut -d '/' -f $nombreSlash`
    
        # Nombre de saisons
        local nombreSaisons=`find "$serie" -mindepth 1 -maxdepth 1 -type d | wc -l`

        # Dernière saison présente (au cas ou toutes les saisons ne seraient pas sur l'O2)
        local derniereSaison=`find "$serie" -mindepth 1 -maxdepth 1 -type d | tr '\n' '%' | cut -d '%' -f $nombreSaisons`

        # Nombre d'épisodes de la dernière saison
        local nombreEpisodes=`ls "$derniereSaison" | wc -l`

        echo "$nom       (${nombreSaisons} saison(s) - ${nombreEpisodes} épisode(s) dans la dernière saison)" >> temp_series_name.txt
    done

    # Tri par ordre alphabétique
    echo "75"; sleep 1
    echo "# Tri par ordre alphabétique des séries ..."; sleep 1
    sort temp_series_name.txt > "Liste des séries du O2.txt"

    # Nettoyage
    echo "99"; sleep 1
    echo "# Suppression des fichiers temporaires crées ..."; sleep 1
    rm temp_series_list.txt temp_series_name.txt
    chmod -x "Liste des séries du O2.txt"
}

# Choix des fichiers à lister
choixListes=`zenity --list --radiolist \
--title="Lister les fichiers du O2 ..." \
--text="Quel(s) fichier(s) voulez-vous lister ?" \
--column="Choix" --column="num" --column="Fichier(s)" --hide-column="2" --print-column="2" \
"${optionsChoix[@]}"`
if [[ "$?" -ne 0 ]]; then
    exit 1;
fi

# Choix des listes à afficher
afficherListes=`zenity --list --radiolist \
--title="Afficher les listes ..." \
--text="Quelles listes voulez-vous afficher ?" \
--column="Choix" --column="num" --column="Liste(s) ..." --hide-column="2" --print-column="2" \
"${optionsAffichage[@]}"`
if [[ "$?" -ne 0 ]]; then
    exit 1;
fi

# Création de la liste des films
if [[ "$choixListes" -eq 1 ]] || [[ "$choixListes" -eq 2 ]]; then
    getMovies "$locationFilms" | zenity --progress --title="Liste des films du O2" --text="Création de la liste en cours ..." --width=900 --height=100 --percentage=0 --auto-close --auto-kill
fi

# Création de la liste des séries
if [[ "$choixListes" -eq 1 ]] || [[ "$choixListes" -eq 3 ]]; then
    getSeries "$locationSeries" | zenity --progress --title="Liste des séries du O2" --text="Création de la liste en cours ..." --width=900 --height=100 --percentage=0 --auto-close --auto-kill
fi

# Affichage de la liste des films si besoin
if [[ "$afficherListes" -eq 1 ]] || [[ "$afficherListes" -eq 2 ]]; then
    zenity --text-info --window-icon=info --title="Liste des films du O2 :" --width=700 --height=900 --filename="Liste des films du O2.txt" &
fi

# Affichage de la liste des séries si besoin
if [[ "$afficherListes" -eq 1 ]] || [[ "$afficherListes" -eq 3 ]]; then
    zenity --text-info --window-icon=info --title="Liste des séries du O2 :" --width=700 --height=900 --filename="Liste des séries du O2.txt" &
fi

IFS="$OLDIFS"

exit 0;
