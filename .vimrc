"#------------------#
"| default settings |
"#------------------#

" encoding
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp

"カーソルを表示行で移動する。物理行移動は<C-n>,<C-p>
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk

" filetype をoff にする
filetype off
filetype plugin indent off

" tiny と small では vimrc を読み込まない
if !1 | finish | endif

" syntax highlight
syntax on
set synmaxcol=200

" syntax highlight for markdown
set syntax=markdown
au BufRead,BufNewFile *.md set filetype=markdown

" 256 color display
set t_Co=256

" indent
set autoindent
set tabstop=4 shiftwidth=4 softtabstop=4
set expandtab

" show line number
set number
set wrap

" do not create backup file
set nobackup

" always show status line
set laststatus=2
set statusline=%y%<%F%m%r%h%w%=\[%l/%L]\[%{&ff}]\[%{&fileencoding}]

" cursor line
set cursorline

" forced show match parentheses
set showmatch

" invalid beep 
set visualbell t_vb=
set noerrorbells

"#-----------#
"| Neobundle |
"#-----------#

if has('vim_starting')
    set rtp+=$HOME/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

"#---------#
"| Plugins |
"#---------#

" nerdtree
NeoBundle 'scrooloose/nerdtree'

" unite.vim
NeoBundle 'Shougo/unite.vim'

" insert brackets automatically
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'tpope/vim-endwise'

" Quickrun
NeoBundle 'thinca/vim-quickrun'

" statusline
NeoBundle 'itchyny/lightline.vim'

" syntastic
NeoBundle 'scrooloose/syntastic'

" complement
NeoBundle 'Shougo/neocomplcache'

" snippets
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

" background transparency
NeoBundle 'miyakogi/seiya.vim'

" vim-surround
NeoBundle 'tpope/vim-surround'

" Dockerfile.vim
NeoBundle 'ekalinin/Dockerfile.vim'

" comment out with ctrl + shift + -
NeoBundle 'tomtom/tcomment_vim'

" show indent line
NeoBundle 'yggdroot/indentLine'

" colorscheme
NeoBundle 'sjl/badwolf'

" html snippets
NeoBundle 'mattn/emmet-vim'

" yaml
NeoBundleLazy 'mrk21/yaml-vim', {
            \ 'autoload' : { 'filetypes' : 'yml' }
            \ }   

" golang
NeoBundleLazy 'fatih/vim-go', {
            \ 'autoload' : { 'filetypes' : 'go' }
            \ }

" preview in browser
NeoBundleLazy 'kannokanno/previm', {
            \   'depends' : [ 'tyru/open-browser.vim' ],
            \   'autoload' : { 'filetypes' : 'markdown' }
            \ }

" open blowser
NeoBundle 'tyru/open-browser.vim'

" Formating ruby code
NeoBundleLazy 'mattn/vim-rubyfmt', {
            \ 'autoload' : { 'filetypes' : 'ruby' }
            \ }

" jedi-vim
NeoBundleLazy 'davidhalter/jedi-vim', {
            \ 'autoload' : { 'filetypes' : 'python' }
            \ }

" modifies vim's imdentation behavior
NeoBundleLazy 'hynek/vim-python-pep8-indent', {
            \ 'autoload' : { 'filetypes' : 'python' }
            \ }

" jedi-vim
NeoBundleLazy 'Flake8-vim', {
            \ 'autoload' : { 'filetypes' : 'python' }
            \ }

" Check for not-installed plugins
NeoBundleCheck

call neobundle#end()

"#-----------------#
"| Plugin settings |
"#-----------------#

"----------
" quickrun
"----------
let g:quickrun_config = {}

" move cursor to quickrun-result
let g:quickrun_config['_'] = {
            \ "outputter/buffer/info" : 1,
            \ }

"-------------
" colorscheme
"-------------
colorscheme badwolf
highlight Normal ctermbg=none

"-----------
" syntastic
"-----------

" when coding ruby, use rubocop
let g:syntastic_mode_map = {
            \ 'mode': 'active',
            \ 'active_filetypes': ['javascript', 'json', 'ruby', 'go', 'python'],
            \ }

let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_python_checkers = ['pyflakes', 'pep8']

"---------------
" NeoComplcache
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

"-------------
" NeoSnippets
"-------------

"expand snippts when Ctrl-k has been pressed
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

"select predction using tab-key
imap <expr><TAB> neosnippet#jumpable() ? 
            \   "\<Plug>(neosnippet_expand_or_jump)" 
            \   : pumvisible() ? "\<C-n>" : "\<TAB>"

smap <expr><TAB> neosnippet#jumpable() ?
            \   "\<Plug>(neosnippet_expand_or_jump)"
            \   : "\<TAB>"

"-------------
" seiya.vim
"-------------

let g:seiya_auto_enable=1

"-------------
" indentLine
"-------------

set list listchars=tab:\¦\ 

"-------------
" NERDTree
"-------------

autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"-------------
" vim-go
"-------------

" syntax-highlighting for Functions, Methods, and Structs
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_fmt_command = "goimports"

"-------------
" pyflakes
"-------------

" run pyflake when program is saved
let g:PyFlakeOnWrite = 1
let g:PyFlakeCheckers = 'pep8,mccabe,pyflakes'
let g:PyFlakeDefaultComplexity=10

"-------------
" filetype
"-------------

filetype plugin indent on
