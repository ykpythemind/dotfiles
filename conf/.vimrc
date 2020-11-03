scriptencoding utf-8
filetype plugin indent on
syntax enable

set autoread
set hidden
set scrolloff=10
set noswapfile
set nobackup
set ambiwidth=double
set mouse=a
set ttimeoutlen=100
set title
set number
set ruler
set wrap
set autoindent
set breakindent
set wildmenu
set wildignore+=*/.git/*,*/tmp/*,*.swp
set cmdheight=2
set laststatus=2
set display=lastline
set showcmd
set synmaxcol=400
set list
set listchars=tab:>-,eol:↲,extends:»,precedes:«,nbsp:%,trail:-
set wildmode=list:longest,full
set clipboard&
set clipboard^=unnamed,unnamedplus
set whichwrap=b,s,h,l,<,>,~,[,]
set backspace=indent,eol,start
set nrformats-=octal
" set lazyredraw
set ttyfast
set updatetime=1000

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

if has('nvim')
  set inccommand=split
endif

let g:mapleader = "\<space>"

" 貼り付け時のカーソル移動
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>
nnoremap Y y$

" 中央に固定しつつスクロール
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz
nnoremap n nzz
nnoremap N Nzz

inoremap <C-j> <Esc>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-k> <C-o>D
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-d> <Del>

cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <C-b>
cnoremap <C-e> <C-e>
cnoremap <C-u> <C-e><C-u>
cnoremap <C-v> <C-f>a
cnoremap <c-x> <c-r>=expand('%:p')<cr>

" 置換
nnoremap gs :<C-u>%s///g<Left><Left><Left>
vnoremap gs :s///g<Left><Left><Left>

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap <C-s> :w<CR>

" replace modeに入らない
map R <Nop>

" 空行挿入
nnoremap <silent> <Space>o :<C-u>for i in range(1, v:count1) \| call append(line('.'),   '') \| endfor<CR>
nnoremap <silent> <Space>O :<C-u>for i in range(1, v:count1) \| call append(line('.')-1, '') \| endfor<CR>

" Two-byte space
"   must before 'colorscheme'
augroup highlightIdegraphicSpace
  autocmd!
  autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

nnoremap <C-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

if executable('git')
  set grepprg=git\ grep\ --no-index\ -I\ --line-number
endif
autocmd QuickfixCmdPost vimgrep copen
autocmd QuickfixCmdPost grep copen

" quickfix
nnoremap <C-n> :cnext<CR>
nnoremap <C-m> :cprevious<CR>
nnoremap <leader>cc :cclose<CR>
nnoremap <leader>co :copen<CR>

if has("multi_lang")
  language C
endif

" Plugin
call plug#begin('~/.vim/plugged')
Plug 'mileszs/ack.vim'
Plug 'justinmk/vim-dirvish'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/ctrlp-matchfuzzy'
Plug 'mattn/ctrlp-register'
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
Plug 'vim-jp/vimdoc-ja'
Plug 'w0ng/vim-hybrid'
Plug 'tomasr/molokai'
Plug 'ntpeters/vim-better-whitespace'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'vue'] }
Plug 'ReekenX/vim-rename2'
Plug 'mattn/emmet-vim'
Plug 'thinca/vim-qfreplace'
" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" lang
Plug 'slim-template/vim-slim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'vim-ruby/vim-ruby'
Plug 'kana/vim-textobj-user'
Plug 'rhysd/vim-textobj-ruby'
call plug#end()
source $VIMRUNTIME/macros/matchit.vim

" golang
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_highlight_extra_types = 1
let g:go_highlight_structs = 1

augroup GolangSettings
  autocmd!
  autocmd FileType go nmap <Leader>i <Plug>(go-info)
  autocmd FileType go setlocal sw=4 ts=4 sts=4 noet
augroup END

" white space
let g:better_whitespace_enabled=0 " disable! (slow down)
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" prettier
nnoremap <Leader>p :Prettier<CR>

"color
set termguicolors
set background=dark
colorscheme hybrid
hi String ctermfg=166 guifg=#ef3434
hi Character ctermfg=166 guifg=#ef3434
hi Delimiter ctermfg=183 guifg=#E58599
hi Comment ctermfg=102
hi Visual ctermbg=236
hi Search ctermbg=24 guibg=#13354A ctermfg=100 guifg=#dddddd

" CtrlP
nnoremap <C-e> :CtrlPBuffer<CR>
let g:ctrlp_prompt_mappings = {
    \ 'PrtSelectMove("j")':   ['<c-j>', '<c-n>'],
    \ 'PrtSelectMove("k")':   ['<c-k>', '<c-p>'],
    \ 'PrtHistory(-1)':       ['<down>'],
    \ 'PrtHistory(1)':        ['<up>'],
    \ }
" let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}

if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast, respects .gitignore
  " and .agignore. Ignores hidden files by default.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -f -g ""'
else
  "ctrl+p ignore files in .gitignore
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
endif

" ack
if executable('ag')
  let g:ackprg = 'ag --smart-case --vimgrep --hidden --ignore .git'
endif
nmap <Leader>a :Ack!<Space>
cnoreabbrev Ag Ack!
cnoreabbrev ag Ack!

" Lightline
function! LightlineFilename()
  return expand('%:t') !=# '' ? expand('%') : '[---]'
endfunction
let g:lightline = {
  \'active': {
  \  'left': [
  \    ['mode', 'paste'],
  \    ['gitbranch', 'readonly', 'filename', 'modified', 'ale'] ],
  \ 'right': [
  \            [ 'filetype' ] ]
  \},
  \'component_function': {
    \   'filename': 'LightlineFilename',
    \   'ale': 'ALEGetStatusLine',
    \   'gitbranch': 'fugitive#head'
  \}
\ }

" ale lint
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '=='
let g:ale_lint_delay = 200
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ }
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
let g:ale_statusline_format = ['[E]%d', '[W]%d', 'ok']
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warn'
let g:ale_set_localist = 1
let g:ale_set_quickfix = 0
let g:ale_set_highlights = 0

" other
if $SHELL =~ '/fish$'
  set shell=bash
endif

