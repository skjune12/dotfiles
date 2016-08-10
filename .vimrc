"#------------------#
"# initial settings #
"#------------------#

" encoding
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
scriptencoding utf-8

" Be iMproved
if &compatible
    set nocompatible
endif

"#----------#
"# dein.vim #
"#----------#

" disable filetype
filetype off

" if dein.vim is not exist
let s:dein_dir = expand('$HOME/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" dein configuration
set runtimepath^=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('$HOME/.cache/dein'))
    " dein.vim
    call dein#add('Shougo/dein.vim')

    " colorscheme
    call dein#add('sjl/badwolf')                " badwolf
    call dein#add('pbrisbin/vim-colors-off')    " off
    call dein#add('zsoltf/vim-maui')            " maui
    call dein#add('andreasvc/vim-256noir')      " 256noir

    " vimproc
    call dein#add('Shougo/vimproc', {
                \   'build' : 'make'
                \ })

    " unite.vim
    call dein#add('Shougo/unite.vim')

    " statusline
    call dein#add('itchyny/lightline.vim')

    " quickrun
    call dein#add('thinca/vim-quickrun')

    " show indent line
    call dein#add('yggdroot/indentLine')

    " complement & snippets
    call dein#add('Shougo/neocomplcache')
    call dein#add('Shougo/neosnippet')
    call dein#add('Shougo/neosnippet-snippets')

    " insert brackets automatically
    call dein#add('Raimondi/delimitMate')
    call dein#add('tpope/vim-endwise')

    " syntax check
    call dein#add('scrooloose/syntastic')

    " golang for vim
    call dein#add('fatih/vim-go')
call dein#end()

" if non-installed plugin exists
if dein#check_install()
    call dein#install()
endif

"#------------------#
"# default settings #
"#------------------#

" enable filetype
filetype plugin on
filetype indent on

" enable 256 colors
set t_Co=256

" enable syntax
if has("syntax")
    syntax on
    set synmaxcol=256
endif

" show line number
set number
set wrap

" set terminal title
set title

" set the width of double-byte character
set ambiwidth=double

" indent settings
set autoindent
"set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

" show invisible words
set list
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" emphasize brackets
set showmatch matchtime=1

" window sprit settings
set splitright
set splitbelow

" search settings
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan

" backspace settings
set backspace=indent,eol,start

" do not make backup file
set nobackup

" do not make swapfile
set noswapfile

" ignore octal format and just use demical
set nrformats-=octal

" compliment on command line
set wildmenu

" always show statusline
set statusline=%y%<%F%m%r%h%w%=\[%l/%L]\[%{&ff}]\[%{&fileencoding}]
set laststatus=2

" invalid beepsound
set visualbell t_vb=
set noerrorbells

" move a cursor by displaying line
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk

" completion of brackets
" inoremap { {}<LEFT>
" inoremap [ []<LEFT>
" inoremap ( ()<LEFT>
" inoremap " ""<LEFT>
" inoremap ' ''<LEFT>
" vnoremap { "zdi^V{<C-R>z}<ESC>
" vnoremap [ "zdi^V[<C-R>z]<ESC>
" vnoremap ( "zdi^V(<C-R>z)<ESC>
" vnoremap " "zdi^V"<C-R>z^V"<ESC>
" vnoremap ' "zdi'<C-R>z'<ESC>

" colorscheme
colorscheme maui
set background=dark

"#------------------#
"# filetype setting #
"#------------------#

" define filetype from filename
autocmd BufNewFile,BufRead *.rb setfiletype ruby
autocmd FileType ruby
    \   set shiftwidth=2 softtabstop=2 expandtab

"#-----------------#
"# plugin settings #
"#-----------------#

"-----------
" lightline
"-----------

let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'mode_map': {'c': 'NORMAL'},
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
            \ },
            \ 'component_function': {
            \   'modified': 'LightLineModified',
            \   'readonly': 'LightLineReadonly',
            \   'fugitive': 'LightLineFugitive',
            \   'filename': 'LightLineFilename',
            \   'fileformat': 'LightLineFileformat',
            \   'filetype': 'LightLineFiletype',
            \   'fileencoding': 'LightLineFileencoding',
            \   'mode': 'LightLineMode'
            \ }
            \ }

function! LightLineModified()
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightLineFilename()
    return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
                \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                \  &ft == 'unite' ? unite#get_status_string() :
                \  &ft == 'vimshell' ? vimshell#get_status_string() :
                \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
        return fugitive#head()
    else
        return ''
    endif
endfunction

function! LightLineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
    return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
    return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

"----------
" quickrun
"----------

let g:quickrun_config = {
            \   "_" : {
            \       "runner" : "vimproc",
            \       "runner/vimproc/updatetime" : 60
            \   },
            \   '*': {'hook/time/enable': '1'},
            \}

"-----------
" syntastic
"-----------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': ['go'] }
let g:syntastic_go_checkers = ['go', 'golint']

"------------
" neosnippet
"------------

" expand snippts when Ctrl-k has been pressed
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" select prediction using tab-key
imap <expr><TAB> neosnippet#jumpable() ? 
            \   '<Plug>(neosnippet_expand_or_jump)'
            \   : pumvisible() ? '<C-n>' : '<TAB>'

smap <expr><TAB> neosnippet#jumpable() ?
            \   '<Plug>(neosnippet_expand_or_jump)'
            \   : '<TAB>'

"---------------
" neocomplcache
"---------------

" enable at startup
let g:neocomplcache_enable_at_startup = 1
" list limitation
let g:neocomplcache_max_list = 30
" start completion at 3 letters
let g:neocomplcache_auto_completion_start_length=3
" use smart case completion with underbar
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
"im settings
let g:neocomplete#lock_iminsert = 1

if has('conceal')
    set conceallevel=2 concealcursor=i
endif

"select prediction on ctrl-n and ctrl-p
inoremap <expr><TAB> pumvisible() ? 
            \   "\<Down>" 
            \   :"\<TAB>"

inoremap <expr><C-Tab> pumvisible() ? 
            \   "\<Up>"
            \   :"\<C-Tab>"

"--------
" vim-go
"--------

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
