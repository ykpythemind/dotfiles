scriptencoding utf-8
filetype plugin indent on
syntax on

set autoread
set hidden
set noswapfile
set ambiwidth=double

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

set list
set listchars=tab:>-,eol:↲,extends:»,precedes:«,nbsp:%,trail:-
set wildmode=list:longest,full
set clipboard=unnamed,autoselect
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

" noremap <C-j> <esc>
" noremap! <C-j> <esc>

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

" Plugin
call plug#begin('~/.vim/plugged')
Plug 'tyru/caw.vim'
Plug 'tpope/vim-surround'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
Plug 'vim-jp/vimdoc-ja'
Plug 'tpope/vim-rails'
Plug 'nathanaelkane/vim-indent-guides', { 'on':  'IndentGuidesToggle' }
Plug 'tomasr/molokai'
Plug 'szw/vim-tags'
Plug 'thinca/vim-ref'
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'bronson/vim-trailing-whitespace'
" Plug 'ykpythemind/vim-fontzoom'
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
call plug#end()
source $VIMRUNTIME/macros/matchit.vim

nnoremap <silent><C-t> :IndentGuidesToggle<CR>

" Use ripgrep
set grepprg=rg\ --vimgrep

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

" fzf
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>x :Commands<CR>
nnoremap <Leader>f :GFiles<CR>
nnoremap <Leader>: :History:<CR>
command! FZFMru call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '40%'})
nnoremap <Leader>r :FZFMru<CR>

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
