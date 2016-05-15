"#------------------#
"# default settings #
"#------------------#

" encoding
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
scriptencoding utf-8

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
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

" show invisible words
set list
:set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" emphasize brackets
set showmatch matchtime=1

" sprit settings
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

" colorscheme
colorscheme industry
