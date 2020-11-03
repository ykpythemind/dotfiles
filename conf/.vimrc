scriptencoding utf-8
filetype plugin indent on
syntax enable

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
" set lazyredraw
set ttyfast
set updatetime=300
set shortmess+=c " coc
set shortmess-=S

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
  set pumblend=10
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

map R <Nop>

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
" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'vim-jp/vimdoc-ja'
Plug 'w0ng/vim-hybrid'
Plug 'koizuss/shareline.vim'
Plug 'tyru/open-browser.vim'
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
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
call plug#end()
source $VIMRUNTIME/macros/matchit.vim

" golang
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_highlight_extra_types = 1
let g:go_highlight_structs = 1
let g:go_fmt_autosave = 1
let g:go_def_mode='gopls'
let g:go_def_mapping_enabled = 0
let g:go_gorename_command = "gopls"

nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

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

" openbrowser
nmap <Leader>b <Plug>(openbrowser-smart-search)
vmap <Leader>b <Plug>(openbrowser-smart-search)

" coc
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

" Use <c-@> to trigger completion.
inoremap <silent><expr> <c-@> coc#refresh()

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
