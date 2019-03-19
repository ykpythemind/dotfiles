scriptencoding utf-8
filetype plugin indent on
syntax on

" https://github.com/SirVer/ultisnips/issues/996
if has('python3')
  silent! python3 1
endif

set autoread
set hidden
set scrolloff=10
set noswapfile
set nobackup
set ambiwidth=double
set foldmethod=manual
set mouse=a
set ttimeoutlen=100
set title
set number
set ruler
set wrap
set autoindent
set smartindent
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

if has('nvim')
  set inccommand=split
endif

set shiftwidth=2
set softtabstop=0
set tabstop=4
set smarttab
set expandtab

set noerrorbells
set novisualbell
set t_vb=

set hlsearch
set incsearch
set nowrapscan
set ignorecase
set smartcase

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

" 置換
nnoremap gs  :<C-u>%s///g<Left><Left><Left>
vnoremap gs  :s///g<Left><Left><Left>

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap <Leader>w :<C-u>write<CR>
nnoremap <C-s> :w<CR>

" 空行挿入
nnoremap <silent> <Leader>o :<C-u>for i in range(1, v:count1) \| call append(line('.'),   '') \| endfor<CR>
nnoremap <silent> <Leader>O :<C-u>for i in range(1, v:count1) \| call append(line('.')-1, '') \| endfor<CR>

" Two-byte space
"   must before 'colorscheme'
augroup highlightIdegraphicSpace
  autocmd!
  autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

nnoremap <C-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

nnoremap <Leader>l :ls<CR>

if executable('git')
  set grepprg=git\ grep\ --no-index\ -I\ --line-number
endif
autocmd QuickfixCmdPost vimgrep copen
autocmd QuickfixCmdPost grep copen

" quickfix
nnoremap <Leader>n :cnext<CR>
nnoremap <Leader>m :cprevious<CR>
nnoremap <leader>cc :cclose<CR>
nnoremap <leader>co :copen<CR>

nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

if has('vim_starting')
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
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'mattn/ctrlp-register'
Plug 'justinmk/vim-dirvish'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
Plug 'vim-jp/vimdoc-ja'
Plug 'tomasr/molokai'
Plug 'cohama/lexima.vim'
Plug 'mbbill/undotree'
Plug 'ntpeters/vim-better-whitespace'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'vue'] }
Plug 'Lokaltog/vim-easymotion'
Plug 'ReekenX/vim-rename2'
Plug 'mattn/emmet-vim'
Plug 'thinca/vim-quickrun'
Plug 'SirVer/ultisnips'
Plug 'thinca/vim-qfreplace'
Plug 'haya14busa/vim-asterisk'
Plug 'junegunn/goyo.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-expand-region'
" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" lang
Plug 'rhysd/vim-crystal'
Plug 'slim-template/vim-slim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'posva/vim-vue'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'elixir-editors/vim-elixir'
Plug 'kana/vim-textobj-user'
Plug 'rhysd/vim-textobj-ruby'
call plug#end()
source $VIMRUNTIME/macros/matchit.vim

" golang
nnoremap <Leader>gr :GoRun<CR>
nnoremap <Leader>gb :GoBuild<CR>
nnoremap <Leader>gt :GoTest<CR>
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_highlight_extra_types = 1
let g:go_highlight_structs = 1
au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl

augroup GolangSettings
  autocmd!
  autocmd FileType go nmap <Leader>i <Plug>(go-info)
  autocmd FileType go setlocal sw=4 ts=4 sts=4 noet
augroup END

" ultisnips
let g:UltiSnipsNoPythonWarning = 1

" asterisk
map *   <Plug>(asterisk-*)
map #   <Plug>(asterisk-#)
map g*  <Plug>(asterisk-g*)
map g#  <Plug>(asterisk-g#)
map z*  <Plug>(asterisk-z*)
map gz* <Plug>(asterisk-gz*)
map z#  <Plug>(asterisk-z#)
map gz# <Plug>(asterisk-gz#)

" white space
let g:better_whitespace_enabled=0  " disable! (slow down)
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" quickrun
nnoremap <Leader>q :QuickRun<CR>

" easymotion
let g:EasyMotion_do_mapping = 0 "Disable default mappings
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-s2)
vmap s <Plug>(easymotion-s2)
nmap S <Plug>(easymotion-overwin-f2)

" Vue
autocmd FileType vue syntax sync fromstart
let g:vue_disable_pre_processors=1

" NERDTree
nnoremap <Leader>t :NERDTreeToggle<CR>
nnoremap <Leader>ft :NERDTreeFocus<CR>
let g:NERDTreeShowHidden=1

" prettier
nnoremap <Leader>p :Prettier<CR>

"color
colorscheme molokai
set t_Co=256
set background=dark
hi String ctermfg=166 guifg=#ef3434
hi Character ctermfg=166 guifg=#ef3434
hi Delimiter ctermfg=183 guifg=#E58599
hi Comment ctermfg=102
hi Visual ctermbg=236
hi Search ctermbg=24 guibg=#13354A ctermfg=100 guifg=#dddddd

" ctrl p
nmap <Leader>h :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden --follow --ignore .git -g ""'
  let g:ctrlp_use_caching = 0
endif
if has('python') || has('python3')
  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif
nnoremap <Leader>fu :CtrlPFunky<Cr>
nnoremap <Leader>r :CtrlPRegister<Cr>
nnoremap <C-e> :CtrlPBuffer<CR>

let g:ctrlp_prompt_mappings = {
  \ 'PrtSelectMove("j")':   ['<c-n>'],
  \ 'PrtSelectMove("k")':   ['<c-p>'],
  \ 'PrtHistory(-1)':       ['<c-j>'],
  \ 'PrtHistory(1)':        ['<c-k>'],
  \ }

" ack
if executable('ag')
  let g:ackprg = 'ag --smart-case --vimgrep --hidden --ignore .git'
endif
nmap <Leader>a :Ack!<Space>
cnoreabbrev Ag Ack!
cnoreabbrev ag Ack!

" Lightline
function! LightlineFilename()
  return expand('%:t') !=# '' ? expand('%') : '[No Name]'
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

" open Browser
noremap <silent> <leader>md :<C-u>!open -a /Applications/Firefox\ Nightly.app "%:p"<cr>

" autocmd VimEnter * if !argc() | Explore | endif
