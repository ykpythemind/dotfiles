filetype plugin indent on
syntax on

set autoread
set hidden
set noswapfile
set nobackup
set ambiwidth=double
" set mouse=a
set ttimeoutlen=100
set title
set ruler
set number
set wrap
set autoindent
set smartindent
set breakindent
set wildmenu
set wildignore+=*/.git/*,*/tmp/*,*.swp
set laststatus=2
set cmdheight=2
set display=lastline
set showcmd
set synmaxcol=200

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
set clipboard&
set clipboard^=unnamed,unnamedplus
set whichwrap=b,s,h,l,<,>,~,[,]
set backspace=indent,eol,start
set nrformats-=octal

let g:mapleader = "\<space>"

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

" improve tab key
for i in range(1, 9)
    execute 'nnoremap <Tab>' . i . ' ' . i . 'gt'
endfor

inoremap <C-j> <Esc>
inoremap <C-p> <Up>
inoremap <C-n> <Down>
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

nnoremap <C-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

if executable('ag')
  " Use ag
  set grepprg=ag\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
endif
autocmd QuickfixCmdPost vimgrep copen
autocmd QuickfixCmdPost grep copen

if has('vim_starting')
    " 縦カーソル
    let &t_SI .= "\e[6 q"
    let &t_EI .= "\e[2 q"
    let &t_SR .= "\e[4 q"
endif

if has("multi_lang")
  language C
endif

" http://vim-jp.org/vim-users-jp/2010/11/03/Hack-181.html
" Open junk file."
command! -nargs=0 JunkFile call s:open_junk_file()
function! s:open_junk_file()
  let l:junk_dir = $HOME . '/.vim_junk'. strftime('/%Y/%m')
  if !isdirectory(l:junk_dir)
    call mkdir(l:junk_dir, 'p')
  endif

  let l:filename = input('Junk Code: ', l:junk_dir.strftime('/%Y-%m-%d-%H%M%S.'))
  if l:filename != ''
    execute 'edit ' . l:filename
  endif
endfunction

" Plugin
call plug#begin('~/.vim/plugged')
Plug 'mileszs/ack.vim'
Plug 'tyru/caw.vim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
Plug 'vim-jp/vimdoc-ja'
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'nathanaelkane/vim-indent-guides', { 'on':  'IndentGuidesToggle' }
Plug 'tomasr/molokai'
Plug 'szw/vim-tags'
Plug 'thinca/vim-ref'
Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-endwise'
" Plug 'prettier/vim-prettier', {
"   \ 'do': 'yarn install',
"   \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }
if executable('fzf')
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
endif
Plug 'posva/vim-vue', { 'for': 'javascript' }
Plug 'kana/vim-textobj-user'
Plug 'tek/vim-textobj-ruby', { 'for': 'ruby' }
Plug 'Lokaltog/vim-easymotion'
Plug 'kana/vim-submode'
Plug 'ReekenX/vim-rename2'
Plug 'mattn/emmet-vim'
Plug 'thinca/vim-quickrun'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'SirVer/ultisnips'
Plug 'slim-template/vim-slim'
call plug#end()
source $VIMRUNTIME/macros/matchit.vim
setlocal omnifunc=syntaxcomplete#Complete

" golang
nnoremap <Leader>gf :GoFmt<CR>
nnoremap <Leader>gr :GoRun<CR>
nnoremap <Leader>gb :GoBuild<CR>
nnoremap <Leader>gt :GoTest<CR>
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
autocmd FileType go nmap <Leader>i <Plug>(go-info)

" quickfix
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>cc :cclose<CR>

" quickrun
nnoremap <Leader>q :QuickRun<CR>

" easymotion
let g:EasyMotion_do_mapping = 0 "Disable default mappings
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_smartcase = 1
" nmap s <Plug>(easymotion-s2)
nmap s <Plug>(easymotion-s2)
vmap s <Plug>(easymotion-s2)
nmap S <Plug>(easymotion-overwin-f2)

" ack.vim
" Tell ack.vim to use ag (the Silver Searcher) instead
let g:ackprg = 'ag --vimgrep'

" Vue
autocmd FileType vue syntax sync fromstart
let g:vue_disable_pre_processors=1

" NERDTree
nnoremap <Leader>t :NERDTreeToggle<CR>

" ctags
nnoremap <C-]> g<C-]>

" prettier
" nnoremap <Leader>p :Prettier<CR>

"color
colorscheme molokai
set t_Co=256
hi String  ctermfg=166 guifg=#ef3434
hi Character ctermfg=166 guifg=#ef3434
hi Delimiter  ctermfg=183 guifg=#E58599
hi Comment ctermfg=102
hi Visual  ctermbg=236
set background=dark

if executable('fzf')
  let g:fzf_buffers_jump = 1
  nmap <Leader>b :Buffers<CR>
  nmap <Leader>r :Tags<CR>
  nmap <C-p> :Files<CR>
  nmap <Leader>a :Ag<CR>
  nmap <Leader>h :History<CR>
  nmap <Leader>x :History:<CR>
endif

" Lightline
function! LightlineFilename()
  return expand('%:t') !=# '' ? expand('%') : '[No Name]'
endfunction
let g:lightline = {
  \'active': {
  \  'left': [
  \    ['mode', 'paste'],
  \    ['readonly', 'filename', 'modified', 'ale'] ],
  \ 'right': [
  \            [ 'filetype' ] ]
  \},
  \'component_function': {
    \   'filename': 'LightlineFilename',
    \   'ale': 'ALEGetStatusLine'
  \}
\ }

" ale lint
" let g:ale_sign_column_always = 1
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '=='
let g:ale_lint_delay = 200
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 1
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

if $SHELL =~ '/fish$'
  set shell=bash
endif

