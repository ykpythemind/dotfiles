scriptencoding utf-8
filetype plugin indent on
syntax enable

set encoding=utf-8
set fenc=utf-8
set autoread
set hidden
set scrolloff=10
set noswapfile
set nobackup
set nowritebackup
"set ambiwidth=double " break telescope
set mouse=a
set ttimeoutlen=100
set title
set number
set wrap
set cursorline
set autoindent
set breakindent
set nosmartindent
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
" set ttyfast
" set lazyredraw
set updatetime=300
set shortmess+=c
set shortmess-=S
set showtabline=2
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
nnoremap / /\v
nnoremap ? ?\v

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
cnoremap <C-v> <C-f>
cnoremap <c-x> <c-r>=expand('%:p')<cr>
cnoremap <c-d> <c-r>=expand('%:p:h')<cr>

nnoremap ! :<C-f>

nnoremap sg :<C-u>%s/\v//g<Left><Left><Left>
vnoremap sg :s/\v//g<Left><Left><Left>
nnoremap s <Nop>
vnoremap s <Nop>

nnoremap j gj
nnoremap k gk

nnoremap n nzvzz
nnoremap N Nzvzz

nnoremap x "_x
xnoremap p "_dP
map <C-b> <Nop>
" blackhole
nnoremap <C-b>dd "_dd
vnoremap <C-b>d "_d

nnoremap <C-s> :w<CR>

nnoremap <Leader>l :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><C-l>

nnoremap <silent> <Space>o :<C-u>for i in range(1, v:count1) \| call append(line('.'), '') \| endfor<CR>

" quickfix
nnoremap <C-n> :Cnext<CR>
nnoremap <C-m> :Cprev<CR>
nnoremap <Leader>cl :cclose<CR>
nnoremap <Leader>co :copen<CR>
" In the quickfix window, <CR> is used to jump to the error under the cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
autocmd FileType qf nnoremap <buffer><silent> q :<C-u>cclose<CR>
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry

augroup disable_auto_comment_when_br
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

" term {{{

" autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-k> <C-\><C-n><C-w>k

tnoremap <silent> <ESC> <C-\><C-n>
tnoremap <silent> <C-j> <C-\><C-n>

" Easier time when pasting content in terminal mode with <C-v> : https://github.com/vimlab/split-term.vim/blob/a4e28cab77ad07fc8a0ebb62a982768c02eb287c/plugin/split-term.vim#L41
" tnoremap <buffer> <expr> <C-v> '<C-\><C-N>pi'

nnoremap <C-t> :ToggleTerm<CR>
tnoremap <C-t> <C-\><C-n>:ToggleTerm<CR>

" }}}

" buffer
nnoremap <Leader>j :bnext<CR>
nnoremap <Leader>k :bprevious<CR>
nnoremap <TAB> :tabn<CR>
nnoremap <S-TAB> :tabp<CR>

" Plugin
call plug#begin('~/.vim/plugged')
Plug '~/git/github.com/ykpythemind/codesearch.vim'

if has('nvim')
  Plug 'neovim/nvim-lspconfig'

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
endif

Plug 'Shougo/ddc.vim'
Plug 'vim-denops/denops.vim'

Plug 'Shougo/ddc-nvim-lsp'
Plug 'Shougo/ddc-around'
Plug 'Shougo/ddc-matcher_head'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'Shougo/deol.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'preservim/vimux'

Plug 'editorconfig/editorconfig-vim'
Plug 'tyru/caw.vim'
Plug 'tpope/vim-surround'
Plug 'thinca/vim-qfreplace'
Plug 'preservim/nerdtree'
Plug 'terryma/vim-expand-region'
Plug 'ConradIrwin/vim-bracketed-paste'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'vim-test/vim-test'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'haya14busa/vim-asterisk'
Plug 'mopp/autodirmake.vim'
Plug 'thinca/vim-zenspace'
Plug 'Asheq/close-buffers.vim'
Plug 'kana/vim-altr'
Plug 'mhinz/vim-grepper'
Plug 'tyru/open-browser.vim'
Plug 'ykpythemind/toggle-term'
Plug 'dhruvasagar/vim-zoom'
if has('nvim')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'tversteeg/registers.nvim', { 'branch': 'main' }
endif
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-localrc'
Plug 'tyru/capture.vim'
Plug 'easymotion/vim-easymotion'
Plug 'mattn/vim-lexiv'

" Git
Plug 'rhysd/git-messenger.vim'
Plug 'mhinz/vim-signify'
Plug 'lambdalisue/gina.vim'
" lang
Plug 'slim-template/vim-slim'
Plug 'mattn/vim-goimports'
" view
Plug 'itchyny/lightline.vim'
Plug 'w0ng/vim-hybrid'
call plug#end()

" ddc
call ddc#custom#patch_global('sources', [
\ 'nvimlsp',
\ 'around',
\ 'vsnip',
\ ])

call ddc#custom#patch_global('sourceOptions', {
\ '_': { 'matchers': ['matcher_head'] },
\ 'around': {'matchers': ['matcher_head'], 'mark': 'A'},
\ 'vsnip': {'mark': 'vsnip'},
\ 'nvimlsp': {
\   'mark': 'lsp',
\   'forceCompletionPattern': '\\.|:|->',
\   'minAutoCompleteLength': 1
\ },
\ })

call ddc#custom#patch_global('sourceParams', {
\ 'around': {'maxSize': 500},
\ })

call ddc#custom#patch_filetype(['typescript', 'go', 'rust'], 'sources', ['nvimlsp', 'vsnip'])
call ddc#custom#patch_filetype(['ruby', 'vim'], 'sources', ['vsnip'])

inoremap <silent><expr> <TAB>
\ pumvisible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#manual_complete()

inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'
call ddc#enable()

" tmp
nnoremap <Leader>s :CodeSearch<cr>

" easymotion
let g:EasyMotion_do_mapping = 0 "Disable default mappings
nmap s <Plug>(easymotion-s2)
nmap <Leader>f <Plug>(easymotion-overwin-f2)

" quickrun
let g:quickrun_no_default_key_mappings = 1
nmap <Leader>r <Plug>(quickrun)
vmap <Leader>r <Plug>(quickrun)

" fzf
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': 'rg --hidden --files'}, <bang>0)
let $FZF_DEFAULT_OPTS = '--reverse'
let g:fzf_layout = { 'up': '45%' }
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \ | autocmd BufLeave <buffer> set laststatus=2 showmode ruler
nnoremap <C-P> :Files<CR>
nnoremap <Leader>h :History<CR>
nnoremap <C-e> :Buffers<CR>
nnoremap L :BLines<CR>
let g:fzf_preview_window = []

" golang

" grepper
let g:grepper = {
  \ 'tools': ['rg', 'git'],
  \ 'rg': {
  \   'grepprg': 'rg --hidden --vimgrep',
  \ }
  \ }
nnoremap F :Grepper -tool rg<cr>
nnoremap <leader>F :Grepper -tool rg -buffer<cr>
xmap F <plug>(GrepperOperator)
let g:grepper.highlight = 1
let g:grepper.switch = 0

" git
let g:git_messenger_date_format = "%Y/%m/%d %X"
nmap <C-g>m <Plug>(git-messenger)

noremap <C-g>b :Gina browse :
nnoremap <C-g>s :Gina status -v --opener=split --group=git<cr>
nnoremap <C-g>c :Gina commit --opener=split --group=git<cr>
nnoremap <C-g>l :Gina log<cr>
nnoremap <C-g>d :Gina diff<cr>
nnoremap <C-g>D :Gina diff

"color
colorscheme hybrid
hi QuickFixLine ctermbg=none ctermfg=none
hi MatchParen guifg=none guibg=#585858

" colorscheme より後におく
let s:true_color_enabled = $TERM_PROGRAM ==# 'iTerm.app' || $TERM_PROGRAM ==# 'alacritty' " || $COLORTERM ==# 'truecolor'
if s:true_color_enabled
  set termguicolors
endif
set background=dark
hi Normal ctermfg=252 ctermbg=16 guifg=#c5c8c6 guibg=#1d1f21

" vim-asterisk
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)

" expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" nerdtree
noremap - :NERDTreeToggle<CR>
noremap = :NERDTreeFind<CR>
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.DS_Store$', '\.git$'] " ignore files in nerd tree
let g:NERDTreeWinSize=50
let NERDTreeMapQuit='='

" Lightline
function! LightlineFilename()
  return expand('%:t') !=# '' ? expand('%') : '[---]'
endfunction
let g:lightline = {
  \'active': {
  \  'left': [
  \    ['mode', 'paste', 'zoom'],
  \    ['readonly', 'filename', 'modified'] ],
  \ 'right': [
  \            [ 'filetype' ] ]
  \},
  \'component_function': {
    \   'filename': 'LightlineFilename',
    \   'gitbranch': 'gina#component#repo#branch',
    \   'zoom': 'zoom#statusline'
  \},
  \'mode_map': { 'n': 'N', 'i': 'I', 'v': 'V' },
  \'tabline': { 'left': [['gitbranch', 'tabs']], 'right': [] }
\ }

" altr
nmap <Leader>J <Plug>(altr-forward)
nmap <Leader>K <Plug>(altr-back)

call altr#define('app/%/%.rb', 'spec/%/%_spec.rb')
call altr#define('config/locales/%en.%yml', 'config/locales/%ja.%yml', 'config/locales/%ko.%yml')
call altr#define('test/test_%.rb', 'test/%_test.rb', 'lib/%.rb', 'spec/%_spec.rb')
call altr#define('%.go', '%_test.go')


" other
set shell=zsh
lang en_US.UTF-8 " paste issue
autocmd FileType help nnoremap <buffer> q <C-w>c
nnoremap T :TestNearest<CR>
nnoremap <Leader>tt :TestNearest<CR>
nnoremap <Leader>tl :TestLast<CR>
let test#neovim#term_position = "botright 30"
" let test#strategy = 'neovim'
let test#strategy = 'vimux'

nmap <Leader>b <Plug>(openbrowser-smart-search)
vmap <Leader>b <Plug>(openbrowser-smart-search)
command! CopyCurrentPath :let @+ = expand('%')
command! Pr exe "!git brws --pr"
command! Code :call Opencode()
nnoremap <Leader>C :Code<CR>
command! Reload bufdo e!

autocmd InsertEnter * :call CheckFileIsEdited()

function! CheckFileIsEdited()
  if &buftype == 'terminal' || &buftype == 'nofile' " ignore some buffer type
    return
  endif

  if getcmdwintype() != ''
   return
  endif

  checktime
endfunction

function! Opencode()
  silent
  let c = expand('%')
  execute("!code " . getcwd())
  if c != ''
    execute("!code -a " . c)
  endif
endfunction
