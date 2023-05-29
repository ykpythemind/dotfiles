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

set undodir=~/.vim/undo
set undofile

let g:mapleader = "\<space>"

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
nnoremap <C-y> <C-^>

nnoremap sg :<C-u>%s/\v//g<Left><Left><Left>
vnoremap sg :s/\v//g<Left><Left><Left>
nnoremap s <Nop>
vnoremap s <Nop>

nnoremap j gj
nnoremap k gk
nnoremap n nzvzz
nnoremap N Nzvzz

vnoremap <silent> y y`]
nnoremap x "_x
xnoremap p "_dP
map <C-b> <Nop>

nnoremap <C-s> :w<CR>

nnoremap <Leader>l :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><C-l>

vnoremap < <gv
vnoremap > >gv

" quickfix
nnoremap <C-n> :Cnext<CR>
nnoremap <C-a> :Cprev<CR>
" In the quickfix window, <CR> is used to jump to the error under the cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
autocmd BufReadPost quickfix nnoremap <buffer><silent> <C-o> :colder<CR>
autocmd BufReadPost quickfix nnoremap <buffer><silent> <C-i> :cnewer<CR>
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry

" open if error on make
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

augroup disable_auto_comment_when_br
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

" nerdtree
noremap - :NERDTreeToggle<CR>
noremap = :NERDTreeFind<CR>
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.DS_Store$', '\.git$'] " ignore files in nerd tree
let g:NERDTreeWinSize=50
let NERDTreeMapQuit='='

" term
tnoremap <silent> <ESC> <C-\><C-n>
tnoremap <silent> <C-j> <C-\><C-n>

" Plugin
call plug#begin()

if has('nvim')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'

  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'numToStr/Comment.nvim'

  Plug 'windwp/nvim-autopairs'
endif

Plug 'preservim/nerdtree'

Plug 'tpope/vim-surround'
Plug 'thinca/vim-qfreplace'
Plug 'terryma/vim-expand-region'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'haya14busa/vim-asterisk'
Plug 'mopp/autodirmake.vim'
Plug 'thinca/vim-zenspace'
Plug 'mhinz/vim-grepper'
Plug 'tyru/open-browser.vim'
Plug 'itchyny/vim-gitbranch'

" view
Plug 'w0ng/vim-hybrid'
Plug 'cocopon/iceberg.vim'
Plug 'yasukotelin/shirotelin'

call plug#end()

      " vim.keymap.set('n', '<C-p>', ':lua launch_filer()<CR>', { noremap = true, silent = false })
      " vim.keymap.set('n', '<C-e>', '<cmd>Telescope buffers<CR>', { noremap = true, silent = false })
nnoremap <C-p> <cmd>Telescope find_files<CR>
nnoremap <C-e> <cmd>Telescope buffers<CR>

if has('nvim')
lua require('Comment').setup()
endif

" grepper
let g:grepper = {
  \ 'tools': ['rg', 'git'],
  \ 'rg': { 'grepprg': 'rg --hidden --vimgrep' },
  \}
nnoremap F :Grepper -tool rg<cr>
nnoremap <leader>F :Grepper -tool rg -buffer<cr>
xmap F <plug>(GrepperOperator)
let g:grepper.highlight = 1
let g:grepper.switch = 0

"color
colorscheme shirotelin
" hi QuickFixLine ctermbg=none ctermfg=none

" colorscheme より後におく
" set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " 文字色
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " 背景色
"set background=dark

map *  <Plug>(asterisk-z*)
vmap v <Plug>(expand_region_expand)
nnoremap <C-j> 5j
nnoremap <C-k> 5k
nnoremap <C-h> 10h
nnoremap <C-l> 10l

set statusline=%<%f\ %m%h%r
set statusline+=%=%l/%L
set statusline+=\ %y

" other
lang en_US.UTF-8 " paste issue

command! Code execute 'silent !code -r ' . getcwd() <bar> execute 'silent :!code -r ' . expand('%')
