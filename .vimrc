scriptencoding utf-8
filetype plugin indent on
syntax on

set autoread
set hidden
set noswapfile
set nobackup
set ambiwidth=double
" set mouse=a
autocmd FileType ruby :set re=1

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

nnoremap <C-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

if executable('rg')
  " Use ripgrep
  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
endif
autocmd QuickfixCmdPost vimgrep copen
autocmd QuickfixCmdPost grep copen
nnoremap [n :<C-u>cn<CR>
nnoremap [p :<C-u>cp<CR>

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
" Open junk file."{{{
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
endfunction "}}}

" Plugin
call plug#begin('~/.vim/plugged')
Plug 'tyru/caw.vim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
Plug 'vim-jp/vimdoc-ja'
Plug 'tpope/vim-rails'
Plug 'nathanaelkane/vim-indent-guides', { 'on':  'IndentGuidesToggle' }
Plug 'tomasr/molokai'
Plug 'szw/vim-tags'
Plug 'thinca/vim-ref'
Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-endwise'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }
" Plug 'roman/golden-ratio'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'posva/vim-vue'
Plug 'kana/vim-textobj-user'
Plug 'tek/vim-textobj-ruby'
Plug 'archseer/colibri.vim'
Plug 'gosukiwi/vim-atom-dark'
Plug 'altercation/vim-colors-solarized'
Plug 'tacahiroy/ctrlp-funky'
Plug 'Lokaltog/vim-easymotion'
Plug 'kana/vim-submode'
Plug 'ReekenX/vim-rename2'
Plug 'mattn/ctrlp-register'
Plug 'mattn/emmet-vim'
" OLD--
" Plug 'Shougo/unite.vim'
" Plug 'Shougo/denite.nvim'
" Plug 'Shougo/neoyank.vim'
" Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
 " Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug '/usr/local/opt/fzf'
" Plug 'junegunn/fzf.vim'
" Plug 'heavenshell/vim-prettier'
" Plug 'jremmen/vim-ripgrep'
call plug#end()
source $VIMRUNTIME/macros/matchit.vim
setlocal omnifunc=syntaxcomplete#Complete

" easymotion
let g:EasyMotion_do_mapping = 0 "Disable default mappings
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-s2)
vmap s <Plug>(easymotion-s2)

" undo - http://haya14busa.com/improve-x-with-vim-submode/
function! s:my_x()
    undojoin
    normal! "_x
endfunction
nnoremap <silent> <Plug>(my-x) :<C-u>call <SID>my_x()<CR>
call submode#enter_with('my_x', 'n', '', 'x', '"_x')
call submode#map('my_x', 'n', 'r', 'x', '<Plug>(my-x)')

" Vue
autocmd FileType vue syntax sync fromstart
let g:vue_disable_pre_processors=1

map <C-t> :NERDTreeToggle<CR>

" ctags
nnoremap <C-]> g<C-]>

" prettier
nnoremap <Leader>p :Prettier<CR>

"color
colorscheme molokai
set t_Co=256
hi String  ctermfg=166 guifg=#ef3434
hi Character ctermfg=166 guifg=#ef3434
hi Delimiter  ctermfg=183 guifg=#E58599
" hi IncSearch ctermfg=193 ctermbg=16
" hi Search ctermfg=23 ctermbg=117 guifg=#005f5f guibg=#87dfff
hi Comment ctermfg=102
hi Visual  ctermbg=236
set background=dark

" CtrlP
if executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --hidden --color=never --glob "!.git/*"'
  " let g:ctrlp_use_caching = 0
endif
nnoremap <C-e> :<C-u>CtrlPBuffer<CR>
nnoremap <Leader>h :<C-u>CtrlPMRU<CR>
" let g:ctrlp_map = ''
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:20'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](.git|doc|tmp|node_modules|vendor)',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }
let g:ctrlp_funky_syntax_highlight = 1
nnoremap <leader>f :CtrlPFunky<CR>
nnoremap <leader>r :CtrlPRegister<CR>

" fzf
if 0
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
let g:fzf_layout = { 'down': '~40%' }
nnoremap <Leader>: :<C-u>History:<CR>
nnoremap <C-h> :<C-u>FZFMru<CR>
nnoremap <C-p> :<C-u>GFiles<CR>
nnoremap <C-e> :<C-u>Buffers<CR>
command! FZFMru call fzf#run({
  \  'source':  v:oldfiles,
  \  'sink':    'e',
  \  'options': '-m -x +s',
  \  'down':    '40%'})
" nnoremap <Leader>r :FZFMru<CR>
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
let g:ale_set_localist = 0
let g:ale_set_quickfix = 1

" for nvim
if has('nvim')
  " nnoremap @t :tabe<CR>:terminal<CR>
  tnoremap <C-q> <C-\><C-n>:q<CR>
  tnoremap <ESC> <C-\><C-n>
endif
