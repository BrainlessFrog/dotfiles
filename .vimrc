" ~/.vimrc
" By BrainlessFrog

" Vundle settings:
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

" Vim plugins:
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
" Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'Yggdroot/indentLine'
Plugin 'Valloric/YouCompleteMe'
Plugin 'easymotion/vim-easymotion'
Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()
filetype plugin indent on

" Vim plugins settings:
" vim-airline
" let g:airline_powerline_fonts = 1
" set laststatus=2
" NERDtree
" map <C-n> :NERDTreeToggle<CR>
" open NERDtree on startup if no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" indentLine
" let g:indentLine_char = '¦'
let g:indentLine_char = '┆'
" let g:indentLine_char = '│'
" EasyMotion
let mapleader = "\<Space>"
" map <SPACE> <Leader>
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

" Vim settings:
syntax on

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

" Colors
colorscheme ron16
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
"    \| exe "normal! g'\"" | endif
"endif

" Settings
set showcmd
set showmatch
set ignorecase
set smartcase
set autoindent
set smartindent
"set autowrite		" Automatically save before commands like :next and :make
"set hidden         " Hide buffers when they are abandoned
set mouse=a
set number
set hlsearch
nnoremap <F8> :nohls <CR>
set incsearch
set backup
set backupdir=~/.vim/backup/
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

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
