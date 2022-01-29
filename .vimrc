scriptencoding utf-8
filetype plugin indent on
syntax enable

set runtimepath^=~/dotfiles/.vim

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
" set ttyfast
" set lazyredraw
set updatetime=300
set shortmess+=c
set shortmess-=S
set showtabline=2
set completeopt=menuone,noinsert,noselect
set signcolumn=number

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
nnoremap M mM
nnoremap gM `M
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
" blackhole
nnoremap <C-b>dd "_dd
vnoremap <C-b>d "_d

nnoremap <C-s> :w<CR>

nnoremap <Leader>l :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><C-l>

nnoremap <silent> <Space>o :<C-u>for i in range(1, v:count1) \| call append(line('.'), '') \| endfor<CR>

" 選択範囲をまとめて動かす
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
vnoremap < <gv
vnoremap > >gv

" quickfix
nnoremap <C-n> :Cnext<CR>
nnoremap <C-m> :Cprev<CR>
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
call plug#begin('~/.vim/plugged')

if has('nvim')
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'numToStr/Comment.nvim'
  Plug 'Shougo/deoppet.nvim', { 'do': ':UpdateRemotePlugins' }

  Plug 'rebelot/kanagawa.nvim'
  Plug 'phaazon/hop.nvim'
endif

" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-denops/denops.vim'

Plug 'Shougo/ddc.vim'
Plug 'Shougo/ddc-around'
Plug 'Shougo/ddc-matcher_head'
Plug 'Shougo/ddc-sorter_rank'
Plug 'Shougo/ddc-nvim-lsp'
Plug 'matsui54/denops-signature_help'

Plug 'christoomey/vim-tmux-navigator'
Plug 'preservim/nerdtree'
Plug 'mbbill/undotree'

Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-surround'
Plug 'thinca/vim-qfreplace'
Plug 'terryma/vim-expand-region'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'vim-test/vim-test'
Plug 'haya14busa/vim-asterisk'
Plug 'mopp/autodirmake.vim'
Plug 'thinca/vim-zenspace'
Plug 'mhinz/vim-grepper'
Plug 'tyru/open-browser.vim'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-localrc'
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
" Git
Plug 'rhysd/git-messenger.vim'
Plug 'mhinz/vim-signify'
Plug 'itchyny/vim-gitbranch'
" lang
Plug 'slim-template/vim-slim'
Plug 'mattn/vim-goimports'
Plug 'leafgarland/typescript-vim'
Plug 'rust-lang/rust.vim'
Plug 'hashivim/vim-terraform'
" view
Plug 'w0ng/vim-hybrid'
Plug 'cocopon/iceberg.vim'
call plug#end()

" call deoppet#initialize()
"
" call deoppet#custom#option('snippets',
"   \ [{ 'path': expand('~/.vim/snippets')}] + map(globpath(&runtimepath, 'neosnippets', 1, 1), { _, val -> { 'path': val } }))
" imap <C-k>  <Plug>(deoppet_expand)

" nmap <silent> g[ <Plug>(coc-diagnostic-prev)
" nmap <silent> g] <Plug>(coc-diagnostic-next)
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
" nmap <leader>cr <Plug>(coc-rename)
" nmap <leader>ca  <Plug>(coc-codeaction)
" nnoremap <leader>d :CocDiagnostics<CR>
"
" nnoremap <silent> K :call <SID>show_documentation()<CR>

call ddc#custom#patch_global('sources', ['around', 'nvim-lsp', 'deoppet'])

" Use matcher_head and sorter_rank.
" https://github.com/Shougo/ddc-matcher_head
" https://github.com/Shougo/ddc-sorter_rank
call ddc#custom#patch_global('sourceOptions', {
  \ '_': {
  \   'matchers': ['matcher_head'], 'sorters': ['sorter_rank'],
  \ },
  \ 'nvim-lsp': { 'mark': 'lsp', 'forceCompletionPattern': '\.\w*|:\w*|->\w*' },
  \ 'deoppet': {'dup': v:true, 'mark': 'dp'},
  \ })

" Change source options
call ddc#custom#patch_global('sourceOptions', {
  \ 'around': {'mark': 'A'},
  \ })
call ddc#custom#patch_global('sourceParams', {
  \ 'around': {'maxSize': 500},
  \ })

call ddc#custom#patch_filetype('markdown', 'sourceParams', {
  \ 'around': {'maxSize': 100},
  \ })

inoremap <silent><expr> <TAB>
\ ddc#map#pum_visible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#map#manual_complete()

inoremap <expr><S-TAB>  ddc#map#pum_visible() ? '<C-p>' : '<C-h>'
call ddc#enable()
call signature_help#enable()

command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 F :call CocAction('format')

" quickrun
let g:quickrun_no_default_key_mappings = 1
nmap <Leader>r <Plug>(quickrun)

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

" git
let g:git_messenger_date_format = "%Y/%m/%d %X"
nmap <C-g>m <Plug>(git-messenger)

"color
" colorscheme hybrid
" colorscheme iceberg
colorscheme kanagawa
hi QuickFixLine ctermbg=none ctermfg=none
hi MatchParen guifg=none guibg=#585858

" colorscheme より後におく
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " 文字色
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " 背景色
set background=dark

map *  <Plug>(asterisk-z*)
vmap v <Plug>(expand_region_expand)
nnoremap H 20h
nnoremap J 10j
nnoremap K 10k
nnoremap L 20l

function! MyTabLine()
  let s = ' ' . gitbranch#name() . ' '
  for i in range(tabpagenr('$'))
    let tab = i + 1 " range() starts at 0
    let winnr = tabpagewinnr(tab) " gets current window of current tab
    let buflist = tabpagebuflist(tab) " list of buffers associated with the windows in the current tab
    let bufnr = buflist[winnr - 1] " current buffer number
    let bufname = bufname(bufnr) " gets the name of the current buffer in the current window of the current tab

    let s .= '%' . tab . 'T' " start a tab
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#') " if this tab is the current tab...set the right highlighting
    let s .= ' ' . tab " current tab number
    let bufmodified = getbufvar(bufnr, "&mod")
    if bufmodified
      let s .= ' +'
    endif
    if bufname != ''
      let s .= ' ' . pathshorten(bufname) . ' ' " or pathshorten(bufname)
    endif
  endfor
  let s .= '%#TabLineFill#' " blank highlighting between the tabs and the righthand close 'X'
  let s .= '%T' " resets tab page number?
  let s .= '%=' " seperate left-aligned from right-aligned
  return s
endfunction
set tabline=%!MyTabLine()

" other
lang en_US.UTF-8 " paste issue
nnoremap <M-w> :Sayonara<CR>
nnoremap <Leader>tt :TestNearest<CR>
nnoremap <Leader>tl :TestLast<CR>
function! BufferTermStrategy(cmd)
  if exists('g:_lastT')
    call win_gotoid(g:_lastT)
  else
    vsplit | term
  endif
  call jobsend(b:terminal_job_id, a:cmd . "\n")
endfunction
let g:test#custom_strategies = {'bufferterm': function('BufferTermStrategy')}
let test#strategy = 'bufferterm'

nmap <Leader>b <Plug>(openbrowser-smart-search)
vmap <Leader>b <Plug>(openbrowser-smart-search)
nnoremap cp :let @+ = expand('%')<CR>
command! Code execute 'silent !code -r ' . getcwd() <bar> execute 'silent :!code -r ' . expand('%')
command! Reload bufdo e!
nnoremap T :new<CR>:term<CR>

autocmd TermEnter,TermOpen,BufEnter * if &buftype ==# 'terminal' | let g:_lastT = win_getid()
autocmd WinLeave * if &buftype !=# 'terminal' | let g:_lastW = win_getid()
nnoremap <expr> <C-t> &buftype ==# 'terminal' ? ':call win_gotoid(g:_lastW)<CR>' : ':call win_gotoid(g:_lastT)<CR>:startinsert<CR>'
tnoremap <C-t> <C-\><C-n>:call win_gotoid(g:_lastW)<CR>

autocmd InsertEnter * :call CheckFileIsEdited()

function! CheckFileIsEdited()
  if getcmdwintype() == '' && &buftype !=# 'terminal' && &buftype !=# 'nofile' " ignore some buffer type
    checktime
  endif
endfunction

command! -nargs=? B :call GHBrowse(<f-args>)

function! GHBrowse(...)
  let b = a:0 == 1 ? ' --branch ' . a:1 : ''
  execute("!gh browse " . expand('%:.') . ":" . line(".") . b)
endfunction

fun! Filename(...) " for snippets
  let template = get(a:000, 0, "$1")
  let arg2 = get(a:000, 1, "")

  let basename = expand('%:t:r')

  if basename == ''
    return arg2
  else
    return substitute(template, '$1', basename, 'g')
  endif
endf

if has('nvim')
  let nvrcmd      = 'nvr -cc split --remote-wait'
  let $VISUAL     = nvrcmd
  let $GIT_EDITOR = nvrcmd
  autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
endif
