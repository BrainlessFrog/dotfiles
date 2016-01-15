" ~/.vimrc
" By BrainlessFrog

" Remap leader
let mapleader = "\<Space>"

" Vundle settings:
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" Plugins
Plugin 'gmarik/Vundle.vim'
" Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'Yggdroot/indentLine'
Plugin 'Valloric/YouCompleteMe'
Plugin 'easymotion/vim-easymotion'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'sjl/gundo.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'ctrlpvim/ctrlp'

" Syntax
Plugin 'baskerville/vim-sxhkdrc'
Plugin 'smancill/conky-syntax.vim'
Plugin 'superbrothers/vim-vimperator'

" Spell files
Plugin 'BrainlessFrog/vim-spell-en-fr'

call vundle#end()
filetype plugin indent on

" Plugins settings:
" vim-airline
" let g:airline_powerline_fonts = 1
" set laststatus=2

" NERDtree
map <Leader>n :NERDTreeToggle<CR>
" Open NERDtree on startup if no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" indentLine
" let g:indentLine_char = '¦'
let g:indentLine_char = '┆'
" let g:indentLine_char = '│'

" EasyMotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_startofline = 0
let g:EasyMotion_smartcase = 1
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
nmap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>e <Plug>(easymotion-bd-e)

" Gundo
let g:gundo_auto_preview = 1
nnoremap <Leader>u :GundoToggle<CR>

" Rainbow Parentheses autostart
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Vim settings:
" Colors
syntax on
colorscheme ron16
set background=dark

" Settings
set number
set showcmd
set showmatch
set showmode
set ruler
set noerrorbells
set novisualbell
set wildmenu
set mouse=a

" Backup
set backup
set backupdir=~/.vim/backup/

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap <F8> :nohls <CR>

" Wrapping
set wrap
set linebreak
map j gj
map k gk

" Redraw
set lazyredraw

" Syntax
set background=dark

" Splits
set splitbelow
set splitright

" Backspace
set backspace=eol,start,indent

" Indent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent

" Folding
set foldenable
set foldmethod=indent
set foldlevel=0

" Spell
"setlocal spell spelllang=fr,en
setlocal spelllang=fr
highlight SpellBad cterm=underline ctermfg=1 ctermbg=NONE

" Toggle spell
function! ToggleSpell()
    if &spell
        set nospell
    else
        set spell
    end
endfunction
noremap <F12> :call ToggleSpell()<cr>
inoremap <F12> <Esc>:call ToggleSpell()<cr>a

" Fix bad copy/paste indentation within tmux
function! WrapForTmux(s)
    if !exists('$TMUX')
        return a:s
    endif

    let tmux_start = "\<Esc>Ptmux;"
    let tmux_end = "\<Esc>\\"

    return tmux_start . substitute(a:s, "\<Esc>","\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction
 
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" LaTex settings
augroup filetypedetect
    au BufNewFile,BufRead *.tex inoremap à \`{a}
    au BufNewFile,BufRead *.tex inoremap À \`{A}
    au BufNewFile,BufRead *.tex inoremap â \^{a}
    au BufNewFile,BufRead *.tex inoremap Â \^{A}
    au BufNewFile,BufRead *.tex inoremap ã \~{a}
    au BufNewFile,BufRead *.tex inoremap Ã \~{A}
    au BufNewFile,BufRead *.tex inoremap é \'{e}
    au BufNewFile,BufRead *.tex inoremap É \'{E}
    au BufNewFile,BufRead *.tex inoremap è \`{e}
    au BufNewFile,BufRead *.tex inoremap È \`{E}
    au BufNewFile,BufRead *.tex inoremap ê \^{e}
    au BufNewFile,BufRead *.tex inoremap Ê \^{E}
    au BufNewFile,BufRead *.tex inoremap ë \"{e}
    au BufNewFile,BufRead *.tex inoremap Ë \"{E}
    au BufNewFile,BufRead *.tex inoremap ẽ \~{e}
    au BufNewFile,BufRead *.tex inoremap Ẽ \~{E}
    au BufNewFile,BufRead *.tex inoremap î \^{i}
    au BufNewFile,BufRead *.tex inoremap Î \^{I}
    au BufNewFile,BufRead *.tex inoremap ï \"{i}
    au BufNewFile,BufRead *.tex inoremap Ï \"{I}
    au BufNewFile,BufRead *.tex inoremap ĩ \~{i}
    au BufNewFile,BufRead *.tex inoremap Ĩ \~{I}
    au BufNewFile,BufRead *.tex inoremap ñ \~{n}
    au BufNewFile,BufRead *.tex inoremap Ñ \~{N}
    au BufNewFile,BufRead *.tex inoremap ô \^{o}
    au BufNewFile,BufRead *.tex inoremap Ô \^{O}
    au BufNewFile,BufRead *.tex inoremap ö \"{o}
    au BufNewFile,BufRead *.tex inoremap Ö \"{O}
    au BufNewFile,BufRead *.tex inoremap õ \~{o}
    au BufNewFile,BufRead *.tex inoremap Õ \~{O}
    au BufNewFile,BufRead *.tex inoremap ù \`{u}
    au BufNewFile,BufRead *.tex inoremap Ù \`{U}
    au BufNewFile,BufRead *.tex inoremap û \^{u}
    au BufNewFile,BufRead *.tex inoremap Û \^{U}
    au BufNewFile,BufRead *.tex inoremap ü \"{u}
    au BufNewFile,BufRead *.tex inoremap Ü \"{U}
    au BufNewFile,BufRead *.tex inoremap ũ \~{u}
    au BufNewFile,BufRead *.tex inoremap Ũ \~{U}
    au BufNewFile,BufRead *.tex inoremap ṽ \~{v}
    au BufNewFile,BufRead *.tex inoremap Ṽ \~{V}
    au BufNewFile,BufRead *.tex inoremap ỹ \~{y}
    au BufNewFile,BufRead *.tex inoremap Ỹ \~{Y}
    au BufNewFile,BufRead *.tex inoremap ç \c{c}
    au BufNewFile,BufRead *.tex inoremap Ç \c{C}
augroup END
