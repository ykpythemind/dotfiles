scriptencoding utf-8
filetype plugin indent on
syntax on

set autoread
" augroup vimrc-checktime
"   autocmd!
"   autocmd WinEnter * checktime
" augroup END
set hidden
set noswapfile
set nobackup
set ambiwidth=double
" set mouse=a
" set lazyredraw
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

" Plugin
call plug#begin('~/.vim/plugged')
Plug 'tyru/caw.vim'
Plug 'tpope/vim-surround'
" Plug 'Shougo/vimproc.vim', {'do' : 'make'}
" Plug 'Shougo/unite.vim'
" Plug 'Shougo/denite.nvim'
" Plug 'Shougo/neomru.vim'
" Plug 'Shougo/neoyank.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
Plug 'vim-jp/vimdoc-ja'
Plug 'tpope/vim-rails'
Plug 'nathanaelkane/vim-indent-guides', { 'on':  'IndentGuidesToggle' }
Plug 'tomasr/molokai'
Plug 'jremmen/vim-ripgrep'
Plug 'szw/vim-tags'
Plug 'thinca/vim-ref'
" Plug 'othree/yajs.vim'
" Plug 'othree/es.next.syntax.vim'
" Plug 'bronson/vim-trailing-whitespace'
" Plug 'ykpythemind/vim-fontzoom'
Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-endwise'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }
" Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
 " Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug '/usr/local/opt/fzf'
" Plug 'junegunn/fzf.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'posva/vim-vue'
Plug 'kana/vim-textobj-user'
Plug 'tek/vim-textobj-ruby'
Plug 'archseer/colibri.vim'
Plug 'gosukiwi/vim-atom-dark'
Plug 'altercation/vim-colors-solarized'
Plug 'tacahiroy/ctrlp-funky'
call plug#end()
source $VIMRUNTIME/macros/matchit.vim
setlocal omnifunc=syntaxcomplete#Complete

" Vue
autocmd FileType vue syntax sync fromstart
let g:vue_disable_pre_processors=1

" nnoremap <silent><C-t> :IndentGuidesToggle<CR>
map <C-t> :NERDTreeToggle<CR>

" ctags
nnoremap <C-]> g<C-]>

"color
"
if 0
colorscheme molokai
set t_Co=256
hi String  ctermfg=166 guifg=#ef3434
hi Character ctermfg=166 guifg=#ef3434
hi Delimiter  ctermfg=183 guifg=#E58599
" hi IncSearch ctermfg=193 ctermbg=16
" hi Search ctermfg=23 ctermbg=117 guifg=#005f5f guibg=#87dfff
hi Comment ctermfg=102
hi Visual  ctermbg=236
end

set t_Co=256
" set termguicolors
set background=dark
colorscheme atom-dark-256
" colorscheme solarized
" let g:solarized_termcolors=256

" denite
" Ripgrep command on grep source
if 0
call denite#custom#var('file_rec', 'command',
  \ ['rg', '--files', '--hidden', '--glob', '!.git', ''])
call denite#custom#source('file_rec', 'matchers', ['matcher_project_files', 'matcher_fuzzy', 'sorter_sublime'])
call denite#custom#source('line', 'matchers', ['matcher_fuzzy', 'sorter_sublime'])
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
nnoremap <Leader>f :<C-u>Denite file file:new<CR>
" nnoremap <Leader>c :<C-u>Denite directory_rec<CR>
nnoremap <Leader>x :<C-u>Denite command_history<CR>
nnoremap <Leader>b :<C-u>Denite buffer<CR>
" nnoremap <Leader>y :<C-u>Denite neoyank<CR>
nnoremap <Leader>r :<C-u>Denite file_mru<CR>
nnoremap <C-t> :<C-u>Denite buffer<CR>
" nnoremap <C-p> :<C-u>DeniteProjectDir file_rec<CR>
" nnoremap <C-g> :<C-u>DeniteProjectDir grep<CR>
nnoremap <C-p> :<C-u>Denite file_rec<CR>
nnoremap <C-l> :<C-u>Denite line<CR>
endif

" fzf
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
"   \   <bang>0 ? fzf#vim#with_preview('up:60%')
"   \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"   \   <bang>0)
" let g:fzf_layout = { 'down': '~40%' }
" nnoremap <Leader>b :<C-u>Buffers<CR>
" nnoremap <Leader>f :<C-u>GFiles<CR>
" nnoremap <Leader>: :<C-u>History:<CR>
" nnoremap <C-h> :<C-u>FZFMru<CR>
" nnoremap <C-p> :<C-u>GFiles<CR>
" nnoremap <C-e> :<C-u>Buffers<CR>
" command! FZFMru call fzf#run({
"   \  'source':  v:oldfiles,
"   \  'sink':    'e',
"   \  'options': '-m -x +s',
"   \  'down':    '40%'})
" nnoremap <Leader>r :FZFMru<CR>

if executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --hidden --color=never --glob "!.git/*"'
  " let g:ctrlp_use_caching = 0
endif
" CtrlP
nnoremap <C-e> :<C-u>CtrlPBuffer<CR>
nnoremap <Leader>h :<C-u>CtrlPMRU<CR>
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](.git|doc|tmp|node_modules)',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }
let g:ctrlp_funky_syntax_highlight = 1
nnoremap <leader>f :CtrlPFunky<CR>

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

" syntax が有効にならないバグ?
filetype plugin indent on
syntax on
" autocmd WinEnter * :filetype detect
" autocmd BufEnter * :filetype detect
" autocmd BufEnter * :filetype plugin indent on

if has("multi_lang")
  language C
endif

" for nvim
tnoremap <silent> <ESC> <C-\><C-n>

