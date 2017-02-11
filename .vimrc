filetype off
filetype plugin indent off
  
syntax enable

set autoread
set wrap
set autoindent
set smartindent

set title
set ruler
set number
set wildmenu
set laststatus=2
set cmdheight=2

set shiftwidth=2
set softtabstop=0
set tabstop=2
set smarttab
set expandtab

set clipboard=unnamedplus

set vb t_vb=
set noerrorbells

set display=lastline

set hlsearch
set incsearch
set wrapscan
set ignorecase
set smartcase

"不可視文字の設定
set list
set listchars=tab:>-,eol:↲,extends:»,precedes:«,nbsp:%

set wildmode=list:longest,full
set showcmd
set clipboard=unnamed,autoselect

set whichwrap=b,s,h,l,<,>,~,[,]

set backspace=indent,eol,start
set nrformats-=octal

"color
autocmd ColorScheme * highlight String  ctermfg=166 guifg=#E5345B
autocmd ColorScheme * highlight Character ctermfg=166 guifg=#E5345B
autocmd ColorScheme * highlight Delimiter  ctermfg=183 guifg=#E58599

colorscheme molokai
set t_Co=256
if &term == "xterm-256color"
    colorscheme molokai
    hi Comment ctermfg=102
    hi Visual  ctermbg=236
endif

filetype plugin on 

