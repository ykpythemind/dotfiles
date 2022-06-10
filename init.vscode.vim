scriptencoding utf-8
filetype plugin indent on
syntax enable

set hidden
set scrolloff=10
set noswapfile
set nobackup
set nowritebackup
set title
set number
set wrap
set cursorline
set autoindent
set breakindent
set nosmartindent
set splitbelow
set splitright
set wildmenu
set cmdheight=2
set laststatus=2
set display=lastline
set backspace=indent,eol,start
set synmaxcol=400
set list
set listchars=tab:>-,eol:↲,extends:»,precedes:«,nbsp:%,trail:-
set clipboard&
set clipboard^=unnamed,unnamedplus
set whichwrap=b,s,h,l,<,>,~,[,]
set shortmess+=c
set shortmess-=S
set showtabline=2
set completeopt=menuone,noinsert,noselect

set shiftwidth=2
set tabstop=4
set smarttab
set expandtab

set noerrorbells
set novisualbell
set t_vb=

set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap / /\v
nnoremap ? ?\v

let g:mapleader = "\<space>"

nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>
nnoremap Y y$
map R <Nop>
noremap ; :

inoremap <C-j> <Esc>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-k> <C-o>D
inoremap <C-a> <cmd>call VSCodeNotify(‘cursorLineStart’)<cr>
inoremap <C-e> <C-o>$

nnoremap M mM
nnoremap gM `M
nnoremap <C-y> <C-^>

nnoremap s <Nop>
vnoremap s <Nop>

" https://github.com/vscode-neovim/vscode-neovim/blob/master/vim/vscode-motion.vim
" https://github.com/vscode-neovim/vscode-neovim/issues/576
nnoremap k <Cmd>call VSCodeNotify('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
nnoremap j <Cmd>call VSCodeNotify('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
nnoremap n nzvzz
nnoremap N Nzvzz

vnoremap <silent> y y`]
nnoremap x "_x
xnoremap p "_dP
map <C-b> <Nop>
" blackhole
nnoremap <C-b>dd "_dd
vnoremap <C-b>d "_d

nnoremap <C-s> <cmd>call VSCodeNotify(‘workbench.action.files.save’)<cr>

nnoremap <Leader>l :nohlsearch<CR><C-l>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><C-l>

nnoremap <silent> <Space>o :<C-u>for i in range(1, v:count1) \| call append(line('.'), '') \| endfor<CR>

vnoremap < <gv
vnoremap > >gv

nnoremap <C-j> 5j
nnoremap <C-k> 5k
nnoremap <C-h> 10h
nnoremap <C-l> 10l

set runtimepath^=~/dotfiles/.vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
call plug#begin('~/.vim/plugged')
Plug 'terryma/vim-expand-region'
Plug 'haya14busa/vim-asterisk'
call plug#end()

map *  <Plug>(asterisk-z*)
vmap v <Plug>(expand_region_expand)

xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

# https://github.com/vscode-neovim/vscode-neovim/issues/293#issuecomment-1078550921
nnoremap <C-d> 26j
nnoremap <C-u> 26k
