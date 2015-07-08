" A 16 colors only version of ron.vim
" Modified from shblah
" By BrainlessFrog

set background=dark
if version > 580
    highlight clear
    if exists("g:syntax_on")
        syntax reset
    endif
endif
let g:colors_name="ron16"

" Colors number - Bold=Bright:
" 0: Black
" 1: Red
" 2: Green
" 3: Yellow
" 4: Blue
" 5: Magenta
" 6: Cyan
" 7: White

" Actual colours and styles.
highlight ColorColumn   term=reverse       cterm=NONE            ctermfg=NONE  ctermbg=1
highlight Comment       term=bold          cterm=bold            ctermfg=6     ctermbg=NONE
highlight Conceal       term=NONE          cterm=NONE            ctermfg=7     ctermbg=NONE
highlight Constant      term=underline     cterm=bold            ctermfg=5     ctermbg=NONE
highlight Cursor        term=NONE          cterm=NONE            ctermfg=NONE  ctermbg=NONE
highlight CursorLine    term=underline     cterm=underline       ctermfg=NONE  ctermbg=NONE
highlight CursorLineNr  term=bold          cterm=bold            ctermfg=3     ctermbg=NONE
highlight DiffAdd       term=bold          cterm=NONE            ctermfg=NONE  ctermbg=4
highlight DiffChange    term=bold          cterm=NONE            ctermfg=NONE  ctermbg=5
highlight DiffDelete    term=bold          cterm=bold            ctermfg=4     ctermbg=6
highlight DiffText      term=reverse       cterm=bold            ctermfg=NONE  ctermbg=1
highlight Directory     term=bold          cterm=bold            ctermfg=6     ctermbg=NONE
highlight Error         term=reverse       cterm=bold            ctermfg=7     ctermbg=1
highlight ErrorMsg      term=standout      cterm=bold            ctermfg=7     ctermbg=1
highlight FoldColumn    term=standout      cterm=bold            ctermfg=6     ctermbg=0
highlight Folded        term=standout      cterm=bold            ctermfg=6     ctermbg=0
highlight Identifier    term=NONE          cterm=bold            ctermfg=6     ctermbg=NONE
highlight Ignore        term=NONE          cterm=NONE            ctermfg=0     ctermbg=NONE
highlight IncSearch     term=reverse       cterm=reverse         ctermfg=NONE  ctermbg=NONE
highlight LineNr        term=underline     cterm=bold            ctermfg=3     ctermbg=NONE
highlight MatchParen    term=reverse       cterm=NONE            ctermfg=NONE  ctermbg=6
highlight ModeMsg       term=bold          cterm=bold            ctermfg=NONE  ctermbg=NONE
highlight MoreMsg       term=bold          cterm=bold            ctermfg=2     ctermbg=NONE
highlight NonText       term=bold          cterm=bold            ctermfg=4     ctermbg=NONE
highlight Normal        term=NONE          cterm=NONE            ctermfg=NONE  ctermbg=NONE
highlight Pmenu         term=NONE          cterm=NONE            ctermfg=0     ctermbg=4
highlight PmenuSbar     term=NONE          cterm=NONE            ctermfg=NONE  ctermbg=7
highlight PmenuSel      term=NONE          cterm=bold            ctermfg=0     ctermbg=0
highlight PmenuThumb    term=NONE          cterm=NONE            ctermfg=NONE  ctermbg=7
highlight PreProc       term=underline     cterm=bold            ctermfg=4     ctermbg=NONE
highlight Question      term=standout      cterm=bold            ctermfg=2     ctermbg=NONE
highlight Search        term=reverse       cterm=NONE            ctermfg=0     ctermbg=3
highlight ShowMarksHL   term=NONE          cterm=bold            ctermfg=6     ctermbg=4
highlight SignColumn    term=standout      cterm=bold            ctermfg=6     ctermbg=0
highlight Special       term=bold          cterm=bold            ctermfg=1     ctermbg=NONE
highlight SpecialKey    term=bold          cterm=bold            ctermfg=4     ctermbg=NONE
highlight SpellBad      term=reverse       cterm=NONE            ctermfg=NONE  ctermbg=1
highlight SpellCap      term=reverse       cterm=NONE            ctermfg=NONE  ctermbg=4
highlight SpellLocal    term=underline     cterm=NONE            ctermfg=NONE  ctermbg=6
highlight SpellRare     term=reverse       cterm=NONE            ctermfg=NONE  ctermbg=5
highlight Statement     term=bold          cterm=bold            ctermfg=3     ctermbg=NONE
highlight StatusLine    term=bold,reverse  cterm=bold,reverse    ctermfg=NONE  ctermbg=NONE
highlight StatusLineNC  term=reverse       cterm=reverse         ctermfg=NONE  ctermbg=NONE
highlight TabLine       term=underline     cterm=bold,underline  ctermfg=7     ctermbg=0
highlight TabLineFill   term=reverse       cterm=reverse         ctermfg=NONE  ctermbg=NONE
highlight TabLineSel    term=bold          cterm=bold            ctermfg=NONE  ctermbg=NONE
highlight Title         term=bold          cterm=bold            ctermfg=5     ctermbg=NONE
highlight Todo          term=standout      cterm=NONE            ctermfg=0     ctermbg=3
highlight Type          term=underline     cterm=bold            ctermfg=2     ctermbg=NONE
highlight Underlined    term=underline     cterm=bold,underline  ctermfg=4     ctermbg=NONE
highlight VertSplit     term=reverse       cterm=reverse         ctermfg=NONE  ctermbg=NONE
highlight Visual        term=reverse       cterm=reverse         ctermfg=NONE  ctermbg=NONE
highlight WarningMsg    term=standout      cterm=bold            ctermfg=1     ctermbg=NONE
highlight WildMenu      term=standout      cterm=NONE            ctermfg=0     ctermbg=3

" General highlighting group links.
highlight! link Boolean         Constant
highlight! link Character       Constant
highlight! link Conditional     Statement
highlight! link Debug           Special
highlight! link Define          PreProc
highlight! link Delimiter       Special
highlight! link Exception       Statement
highlight! link Float           Number
highlight! link Function        Identifier
highlight! link Include         PreProc
highlight! link Keyword         Statement
highlight! link Label           Statement
highlight! link Macro           PreProc
highlight! link Number          Constant
highlight! link Operator        Statement
highlight! link PreCondit       PreProc
highlight! link Repeat          Statement
highlight! link SpecialChar     Special
highlight! link SpecialComment  Special
highlight! link StorageClass    Type
highlight! link String          Constant
highlight! link Structure       Type
highlight! link Tag             Special
highlight! link Typedeff        Type
highlight! link diffAdded       DiffAdd
highlight! link diffRemoved     DiffDelete
highlight! link diffChanged     DiffChange
highlight! link VimHiGroup      VimGroup

" Test the actual colorscheme
syn match Comment       "\"__Comment.*"
syn match Constant      "\"__Constant.*"
syn match Cursor        "\"__Cursor.*"
syn match CursorLine    "\"__CursorLine.*"
syn match DiffAdd       "\"__DiffAdd.*"
syn match DiffChange    "\"__DiffChange.*"
syn match DiffText      "\"__DiffText.*"
syn match DiffDelete    "\"__DiffDelete.*"
syn match Folded        "\"__Folded.*"
syn match Function      "\"__Function.*"
syn match Identifier    "\"__Identifier.*"
syn match IncSearch     "\"__IncSearch.*"
syn match NonText       "\"__NonText.*"
syn match Normal        "\"__Normal.*"
syn match Pmenu         "\"__Pmenu.*"
syn match PreProc       "\"__PreProc.*"
syn match Search        "\"__Search.*"
syn match Special       "\"__Special.*"
syn match SpecialKey    "\"__SpecialKey.*"
syn match Statement     "\"__Statement.*"
syn match StatusLine    "\"__StatusLine.*"
syn match StatusLineNC  "\"__StatusLineNC.*"
syn match String        "\"__String.*"
syn match Todo          "\"__Todo.*"
syn match Type          "\"__Type.*"
syn match Underlined    "\"__Underlined.*"
syn match VertSplit     "\"__VertSplit.*"
syn match Visual        "\"__Visual.*"

"__Comment              /* this is a comment */
"__Constant             var = SHBLAH
"__Cursor               char under the cursor?
"__CursorLine           Line where the cursor is
"__DiffAdd              +line added from file.orig
"__DiffChange           line changed from file.orig
"__DiffText             actual changes on this line
"__DiffDelete           -line removed from file.orig
"__Folded               +--- 1 line : Folded line ---
"__Function             function sblah()
"__Identifier           Never ran into that actually...
"__IncSearch            Next search term
"__NonText              This is not a text, move on
"__Normal               Typical text goes like this
"__Pmenu                Currently selected menu item
"__PreProc              #define SHBLAH true
"__Search               This is what you're searching for
"__Special              true false NULL SIGTERM
"__SpecialKey           Never ran into that either
"__Statement            if else return for switch
"__StatusLine           Statusline of current windows
"__StatusLineNC         Statusline of other windows
"__String               "Hello, World!"
"__Todo                 TODO: remove todos from source
"__Type                 int float char void unsigned uint32_t
"__Underlined           Anything underlined
"__VertSplit            :vsplit will only show ' | '
"__Visual               Selected text looks like this
