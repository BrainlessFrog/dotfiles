" Fichier de lancement des templates
" Voir http://www.wiki-linux.fr/index.php?title=Vim

function! NewBASHfile()
    0r ~/.vim/templates/new.sh
    exec "normal 3j"
    start
endfunction

au! BufNewFile *.sh call NewBASHfile()

function! NewPYTHONfile()
    0r ~/.vim/templates/new.py
    exec "normal 3j"
    start
endfunction

au! BufNewFile *.py call NewPYTHONfile()
