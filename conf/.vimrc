scriptencoding utf-8
filetype plugin indent on
syntax enable

set encoding=utf-8
set fenc=utf-8
set autoread
set hidden
set scrolloff=10
set noswapfile
set nobackup " coc
set nowritebackup " coc
set ambiwidth=double
set mouse=a
set ttimeoutlen=100
set title
set number
set wrap
set cursorline
set autoindent
set breakindent
set splitbelow
set splitright
set wildmenu
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
" set lazyredraw
set ttyfast
set updatetime=300
set shortmess+=c " coc
set shortmess-=S

set shiftwidth=2
set tabstop=4
set smarttab

set noerrorbells
set novisualbell
set t_vb=

set hlsearch
set incsearch
set ignorecase
set smartcase

if has('nvim')
  set inccommand=split
  set pumblend=10
  " let g:ruby_host_prog = '~/.rbenv/versions/2.7.0/bin/neovim-ruby-host'
  " let g:python3_host_prog = '~/.pyenv/shims/python3'
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
map R <Nop>

inoremap <C-j> <Esc>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-k> <C-o>D
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$

cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <C-b>
cnoremap <C-e> <C-e>
cnoremap <C-u> <C-e><C-u>
cnoremap <C-v> <C-f>a
cnoremap <c-x> <c-r>=expand('%:p')<cr>

" 置換
nnoremap sg :<C-u>%s///g<Left><Left><Left>
vnoremap sg :s///g<Left><Left><Left>
vnoremap s <Nop>

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap tn :<C-u>tabnew<CR>
nnoremap tl gt
nnoremap th gT

nnoremap <C-s> :w<CR>

" 空行挿入
nnoremap <silent> <Space>o :<C-u>for i in range(1, v:count1) \| call append(line('.'),   '') \| endfor<CR>
nnoremap <silent> <Space>O :<C-u>for i in range(1, v:count1) \| call append(line('.')-1, '') \| endfor<CR>

" Two-byte space --- must before 'colorscheme'
augroup highlightIdegraphicSpace
  autocmd!
  autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

nnoremap <C-l> :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><C-l>

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
" In the quickfix window, <CR> is used to jump to the error under the cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" window
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h

" 改行時にコメントさせない
augroup auto_comment_off
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
augroup END

" term
autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
tnoremap <C-q> <C-\><C-n>:q<CR>
tnoremap <C-j> <C-\><C-n>
tnoremap <ESC> <C-\><C-n>

if has("multi_lang")
  language C
endif

" Plugin
call plug#begin('~/.vim/plugged')
Plug 'mileszs/ack.vim'
Plug 'cohama/lexima.vim'
Plug 'justinmk/vim-dirvish'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'koizuss/shareline.vim'
Plug 'eugen0329/vim-esearch'
Plug 'tyru/open-browser.vim'
Plug 'ReekenX/vim-rename2'
Plug 'thinca/vim-qfreplace'
Plug 'ntpeters/vim-better-whitespace'
Plug 'lambdalisue/fern.vim'
" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" lang
Plug 'slim-template/vim-slim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'vim-ruby/vim-ruby'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
" view
Plug 'itchyny/lightline.vim'
Plug 'w0ng/vim-hybrid'
call plug#end()
source $VIMRUNTIME/macros/matchit.vim

" golang
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_highlight_extra_types = 1
let g:go_highlight_structs = 1
let g:go_def_mode='gopls'
let g:go_def_mapping_enabled = 0
let g:go_gorename_command = "gopls"

augroup GolangSettings
  autocmd!
  autocmd FileType go setlocal sw=4 ts=4 sts=4 noet
augroup END

" openbrowser
nmap <Leader>b <Plug>(openbrowser-smart-search)
vmap <Leader>b <Plug>(openbrowser-smart-search)

" white space
let g:better_whitespace_enabled=0 " disable! (slow down)
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" coc
let g:coc_global_extensions = [
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-eslint',
      \ 'coc-tslint-plugin',
      \ 'coc-prettier',
      \ 'coc-solargraph',
      \ 'coc-stylelint',
      \ ]

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"color
set background=dark
set termguicolors
colorscheme hybrid
hi String ctermfg=166 guifg=#d75f00
hi LineNr ctermfg=2 guifg=#4c535c

" fern
nnoremap <C-t> :Fern . -reveal=%<CR>
let g:fern#default_hidden = 1

function! s:init_fern() abort
  nmap <buffer> h <Plug>(fern-action-leave)
endfunction
augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

" CtrlP
nnoremap <C-e> :CtrlPBuffer<CR>
let g:ctrlp_prompt_mappings = {
    \ 'PrtSelectMove("j")':   ['<c-j>', '<c-n>'],
    \ 'PrtSelectMove("k")':   ['<c-k>', '<c-p>'],
    \ 'PrtHistory(-1)':       ['<down>'],
    \ 'PrtHistory(1)':        ['<up>'],
    \ }

if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -f -g ""'
endif

" ack
if executable('ag')
  let g:ackprg = 'ag --smart-case --vimgrep --hidden'
endif
nmap <Leader>a :Ack!<Space>

" Lightline
function! LightlineFilename()
  return expand('%:t') !=# '' ? expand('%') : '[---]'
endfunction
let g:lightline = {
  \'active': {
  \  'left': [
  \    ['mode', 'paste'],
  \    ['gitbranch', 'readonly', 'filename', 'modified'] ],
  \ 'right': [
  \            [ 'filetype', 'coc' ] ]
  \},
  \'component_function': {
    \   'filename': 'LightlineFilename',
    \   'gitbranch': 'fugitive#head',
    \   'coc': 'coc#status'
  \}
\ }

" other
set shell=fish
