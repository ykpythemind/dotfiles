set nocompatible
scriptencoding utf-8
filetype plugin indent on
syntax on

set autoread
set title
set ruler
set number
set wrap
set autoindent
set smartindent
set breakindent
set wildmenu
set laststatus=2
set cmdheight=2
set display=lastline

set shiftwidth=2
set softtabstop=0
set tabstop=2
set smarttab
set expandtab

set vb t_vb=
set noerrorbells

set hlsearch
set incsearch
set wrapscan
set ignorecase
set smartcase

set nocursorline
set noshowmatch

set list
set listchars=tab:>-,eol:↲,extends:»,precedes:«,nbsp:%,trail:-
set wildmode=list:longest,full
set showcmd
set clipboard=unnamed,autoselect
set whichwrap=b,s,h,l,<,>,~,[,]
set backspace=indent,eol,start
set nrformats-=octal
set hidden

nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>

nnoremap Y y$

inoremap <silent> jj <ESC>
noremap <C-j> <esc>
noremap! <C-j> <esc>

nnoremap <Space>w  :<C-u>w<CR>

cnoremap <C-f>  <Right>
cnoremap <C-b>  <Left>
cnoremap <C-a>  <C-b>
cnoremap <C-e>  <C-e>
cnoremap <C-u> <C-e><C-u>
cnoremap <C-v> <C-f>a

nnoremap gs  :<C-u>%s///g<Left><Left><Left>
vnoremap gs  :s///g<Left><Left><Left>

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" auto open QuickFix
autocmd QuickFixCmdPost vimgrep cwindow

" redraw and :noh
nnoremap <silent> <C-L> :noh<C-L><CR>

call plug#begin('~/.vim/plugged')
Plug 'tyru/caw.vim'
Plug 'tpope/vim-surround'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neoyank.vim'
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
Plug 'vim-jp/vimdoc-ja'
Plug 'tpope/vim-rails'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tomasr/molokai'
call plug#end()

nnoremap <silent><C-t> :IndentGuidesToggle<CR>

"color

colorscheme molokai
set t_Co=256
if &term == "xterm-256color"
    colorscheme molokai
    hi Comment ctermfg=102
    hi Visual  ctermbg=236
endif
hi String  ctermfg=166 guifg=#E5345B
hi Character ctermfg=166 guifg=#E5345B
hi Delimiter  ctermfg=183 guifg=#E58599
hi IncSearch ctermfg=193 ctermbg=16
hi Search ctermfg=23 ctermbg=117 guifg=#005f5f guibg=#87dfff

" Two-byte space
highlight JpSpace cterm=reverse ctermfg=166 gui=reverse guifg=Red
au BufRead,BufNew * match JpSpace /　/

" Unite
let g:unite_enable_start_insert=1
let g:unite_source_file_mru_limit = 100
nnoremap <silent> <Space>y :<C-u>Unite history/yank<CR>
nnoremap <silent> <Space>b :<C-u>Unite buffer<CR>
nnoremap <silent> <Space>c :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <silent> <Space>f :<C-u>UniteWithCurrentDir -buffer-name=files file file/new<CR>
nnoremap <silent> <Space>u :<C-u>Unite file_mru buffer<CR>

" Lightline
let g:lightline = {
  \'active': {
  \  'left': [
  \    ['mode', 'paste'],
  \    ['readonly', 'filename', 'modified', 'ale'],
  \  ]
  \},
  \'component_function': {
  \  'ale': 'ALEGetStatusLine'
  \}
\ }

" lint
" let g:ale_sign_column_always = 1
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '=='
