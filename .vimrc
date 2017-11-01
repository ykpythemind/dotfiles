scriptencoding utf-8
filetype plugin indent on
syntax on

set nocompatible
set autoread
set hidden
set noswapfile
set ambiwidth=double
set mouse=a

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
set showcmd
set nocursorline
set noshowmatch

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
nnoremap <ESC><ESC> :nohlsearch<CR>

set list
set listchars=tab:>-,eol:↲,extends:»,precedes:«,nbsp:%,trail:-
set wildmode=list:longest,full
set clipboard&
set clipboard^=unnamed,unnamedplus
set whichwrap=b,s,h,l,<,>,~,[,]
set backspace=indent,eol,start
set nrformats-=octal

let mapleader = "\<space>"
nnoremap <Leader>k :bd<CR>

nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>
nnoremap Y y$

" 中央に固定しつつスクロール
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

noremap <C-j> <esc>
noremap! <C-j> <esc>

cnoremap <C-f>  <Right>
cnoremap <C-b>  <Left>
cnoremap <C-a>  <C-b>
cnoremap <C-e>  <C-e>
cnoremap <C-u> <C-e><C-u>
cnoremap <C-v> <C-f>a

" 置換
nnoremap gs  :<C-u>%s///g<Left><Left><Left>
vnoremap gs  :s///g<Left><Left><Left>

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" 空行挿入
nnoremap <silent> <Space>o   :<C-u>for i in range(1, v:count1) \| call append(line('.'),   '') \| endfor<CR>
nnoremap <silent> <Space>O   :<C-u>for i in range(1, v:count1) \| call append(line('.')-1, '') \| endfor<CR>

" Two-byte space
highlight JpSpace cterm=reverse ctermfg=166 gui=reverse guifg=Red
au BufRead,BufNew * match JpSpace /　/

autocmd QuickfixCmdPost vimgrep copen
autocmd QuickfixCmdPost grep copen

" Plugin
call plug#begin('~/.vim/plugged')
Plug 'tyru/caw.vim'
Plug 'tpope/vim-surround'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
" Plug 'Shougo/unite.vim'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neoyank.vim'
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
Plug 'vim-jp/vimdoc-ja'
Plug 'tpope/vim-rails'
Plug 'nathanaelkane/vim-indent-guides', { 'on':  'IndentGuidesToggle' }
Plug 'tomasr/molokai'
Plug 'jremmen/vim-ripgrep'
Plug 'szw/vim-tags'
Plug 'thinca/vim-ref'
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ykpythemind/vim-fontzoom'
Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-endwise'
" Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
call plug#end()
source $VIMRUNTIME/macros/matchit.vim

nnoremap <silent><C-t> :IndentGuidesToggle<CR>

" ctags
nnoremap <C-]> g<C-]>

"color
colorscheme molokai
set t_Co=256
hi String  ctermfg=166 guifg=#ef3434
hi Character ctermfg=166 guifg=#ef3434
hi Delimiter  ctermfg=183 guifg=#E58599
hi IncSearch ctermfg=193 ctermbg=16
hi Search ctermfg=23 ctermbg=117 guifg=#005f5f guibg=#87dfff
hi Comment ctermfg=102
hi Visual  ctermbg=236

if executable('rg')
  " Use ripgrep
  set grepprg=rg\ --vimgrep
endif

" denite
" Ripgrep command on grep source
call denite#custom#var('file_rec', 'command',
  \ ['rg', '--files', '--hidden', '--glob', '!.git', ''])
call denite#custom#source('file_rec', 'matchers', ['matcher_fuzzy', 'sorter_rank'])
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
    \ ['--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#map('insert', "<C-k>", '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', "<C-j>", '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<Up>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<Down>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#option('default', { 'reversed': 1, 'auto_resize': 1, 'smartcase': 1,
  \ 'highlight_mode_insert': 'Search',
  \ 'highlight_matched_char': 'Visual' })
let g:python3_host_prog = expand('/usr/local/bin/python3')
nnoremap <Leader>f :<C-u>Denite file<CR>
nnoremap <Leader>b :<C-u>Denite buffer<CR>
nnoremap <Leader>y :<C-u>Denite neoyank<CR>
nnoremap <Leader>r :<C-u>Denite file_mru<CR>
nnoremap <C-l> :<C-u>Denite buffer<CR>
nnoremap <C-p> :<C-u>DeniteProjectDir file_rec<CR>
nnoremap <C-g> :<C-u>DeniteProjectDir grep<CR>

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

" ale lint
" let g:ale_sign_column_always = 1
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '=='
let g:ale_lint_delay = 200
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 1
let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ }
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
