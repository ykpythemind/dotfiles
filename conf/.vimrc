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
set backspace=indent,eol,start
set synmaxcol=400
set list
set listchars=tab:>-,eol:↲,extends:»,precedes:«,nbsp:%,trail:-
set clipboard&
set clipboard^=unnamed,unnamedplus
set whichwrap=b,s,h,l,<,>,~,[,]
set ttyfast
set updatetime=300
set shortmess+=c " coc
set shortmess-=S

set completeopt=menuone,noinsert,noselect

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

vnoremap <silent> y y`]

nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>
nnoremap Y y$
map R <Nop>
noremap ; :

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

nnoremap sg :<C-u>%s///g<Left><Left><Left>
vnoremap sg :s///g<Left><Left><Left>
vnoremap s <Nop>

nnoremap j gj
nnoremap k gk

nnoremap n nzvzz
nnoremap N Nzvzz
" xでレジスタ使わない
nnoremap x "_x

nnoremap <C-s> :w<CR>

nnoremap <C-l> :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><C-l>

" quickfix
nnoremap <C-n> :Cnext<CR>
nnoremap <C-m> :Cprev<CR>
" In the quickfix window, <CR> is used to jump to the error under the cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
autocmd FileType qf nnoremap <buffer><silent> q :<C-u>cclose<CR>
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry

" 改行時にコメントさせない
augroup auto_comment_off
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
augroup END

" term
autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
tnoremap <ESC> <C-\><C-n>
" Easier time when pasting content in terminal mode with <C-v> : https://github.com/vimlab/split-term.vim/blob/a4e28cab77ad07fc8a0ebb62a982768c02eb287c/plugin/split-term.vim#L41
tnoremap <buffer> <expr> <C-v> '<C-\><C-N>pi'
command! Spterm split | startinsert | term
nnoremap <C-t> :Spterm<CR>
tnoremap <C-t> <C-\><C-N><C-w><C-w>

" Plugin
call plug#begin('~/.vim/plugged')
Plug 'cohama/lexima.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'commit': 'ad1793dce0a59afcf8b324b45a1168c032deb162'}
" Plug 'k0kubun/vim-open-github'
Plug 'thinca/vim-qfreplace'
Plug 'ntpeters/vim-better-whitespace'
Plug 'preservim/nerdtree'
Plug 'mhinz/vim-grepper'
Plug 'terryma/vim-expand-region'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-test/vim-test'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'junegunn/vim-peekaboo'
Plug 'haya14busa/vim-asterisk'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'thinca/vim-zenspace'
" Git
Plug 'rhysd/git-messenger.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" lang
Plug 'slim-template/vim-slim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tpope/vim-rails'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
" view
Plug 'itchyny/lightline.vim'
Plug 'w0ng/vim-hybrid'
call plug#end()
source $VIMRUNTIME/macros/matchit.vim

" buffer
nnoremap <C-E> :BuffergatorToggle<CR>

" fzf
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': 'ag --hidden -g ""'}, <bang>0)
" command! -bang -nargs=? -complete=dir Buffers
"   \ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview(), <bang>0)
let $FZF_DEFAULT_OPTS = '--reverse'
let g:fzf_layout = { 'up': '45%' }
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \ | autocmd BufLeave <buffer> set laststatus=2 showmode ruler
if has("nvim")
  au TermOpen * tnoremap <Esc> <c-\><c-n>
  au FileType fzf tunmap <Esc>
endif
nmap <C-P> :Files<CR>
nmap <C-H> :History<CR>
nmap <Leader><C-H> :History:<CR>
nmap <Leader><C-P> :Commands<CR>
let g:fzf_preview_window = []

" golang
let g:go_fmt_autosave = 0 " 0 == disable: coc.nvimを壊す
let g:go_list_type = "quickfix"
let g:go_highlight_extra_types = 1
let g:go_highlight_structs = 1
let g:go_def_mode='gopls'
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_gorename_command = "gopls"
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

augroup GolangSettings
  autocmd!
  autocmd FileType go setlocal sw=4 ts=4 sts=4 noet
augroup END

" white space
let g:better_whitespace_enabled=0 " disable! (slow down)
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" git
let g:git_messenger_date_format = "%Y/%m/%d %X"
nmap <C-g>m <Plug>(git-messenger)

" coc
" let $NVIM_COC_LOG_LEVEL = 'debug'
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
      \ 'coc-go',
      \ ]

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<down>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<up>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position. Coc only does snippet and additional edit on confirm.
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
nmap <silent> g] <Plug>(coc-diagnostic-next)
nmap <silent> g[ <Plug>(coc-diagnostic-prev)

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"color
set background=dark
let s:true_color_enabled = $TERM_PROGRAM ==# 'iTerm.app'
if s:true_color_enabled
  set termguicolors
endif

colorscheme hybrid
hi String ctermfg=166 guifg=#d75f00
hi LineNr ctermfg=2 guifg=#4c535c
hi Normal ctermfg=250 guifg=#f0f5f2
hi QuickFixLine term=reverse ctermbg=52

" vim-asterisk
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)

" grepper
let g:grepper = {
  \ 'tools': ['ag', 'git'],
  \ 'ag': {
  \   'grepprg': 'ag --hidden --vimgrep',
  \ }
  \ }
nmap F :Grepper -tool ag<cr>
nmap <leader>F :Grepper -tool ag -buffer<cr>
xmap F <plug>(GrepperOperator)
let g:grepper.highlight = 1
let g:grepper.switch = 0

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" nerdtree
" nmap <leader>t :NERDTreeToggle<CR>
nmap - :NERDTreeToggle<CR>
nmap = :NERDTreeFind<CR>
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.DS_Store$', '\.git$'] " ignore files in nerd tree
let NERDTreeQuitOnOpen = 1

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
let g:lightline.colorscheme = 'solarized'

" lexima
let g:lexima_enable_endwise_rules = 0 " disable

" other
set shell=fish
lang en_US.UTF-8 " paste issue
autocmd FileType help nnoremap <buffer> q <C-w>c

augroup vimrcEx
  " 前開いていた場所
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

command! CopyCurrentPath :call s:copy_current_path()
function! s:copy_current_path() abort
  let c = expand('%:p')
  if &clipboard =~# 'plus$'
      let @+ = c
  else
      let @* = c
  endif
endfunction

