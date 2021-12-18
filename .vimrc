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
set nonumber
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

set undodir=~/.vim/undo
set undofile

let g:mapleader = "\<space>"

vnoremap <silent> y y`]

nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>
nnoremap Y y$
map R <Nop>
noremap ; :

inoremap <C-j> <Esc>
" inoremap <C-c> <Esc>
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
autocmd FileType qf nnoremap <buffer><silent> q :<C-u>cclose<CR>
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry

" open if error on make
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

augroup qfopen-bufenter
  function! s:qfopen_keymap() abort
    nmap <buffer> a <Plug>(qfopen-action)
    nmap <buffer> <C-v> <Plug>(qfopen-open-vsplit)
    nmap <buffer> <C-x> <Plug>(qfopen-open-split)
  endfunction
  au!
  au FileType qf call s:qfopen_keymap()
augroup END

augroup disable_auto_comment_when_br
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

let g:winresizer_start_key=''
let g:winresizer_vert_resize=3
nnoremap <C-w>r :WinResizerStartResize<CR>

" term {{{

" autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-k> <C-\><C-n><C-w>k

tnoremap <silent> <ESC> <C-\><C-n>
tnoremap <silent> <C-j> <C-\><C-n>
nnoremap <C-t> :ToggleTerm<CR>
tnoremap <C-t> <C-\><C-n>:ToggleTerm<CR>

" }}}

if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Plugin
call plug#begin('~/.vim/plugged')
" Plug 'neoclide/coc.nvim', {'branch': 'release'}


if has('nvim')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'neovim/nvim-lspconfig'

  Plug 'nvim-lua/plenary.nvim'
  Plug 'ThePrimeagen/harpoon'
  Plug 'nvim-telescope/telescope.nvim'

  Plug 'ray-x/lsp_signature.nvim'

  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'nvim-lualine/lualine.nvim'

  Plug 'mhartington/formatter.nvim'
endif

Plug 'Shougo/ddc.vim'
Plug 'vim-denops/denops.vim'

Plug 'Shougo/ddc-nvim-lsp'
Plug 'Shougo/ddc-around'
Plug 'Shougo/ddc-matcher_head'
" Plug 'hrsh7th/vim-vsnip'
" Plug 'hrsh7th/vim-vsnip-integ'
Plug 'matsui54/ddc-buffer'
Plug 'tani/ddc-fuzzy'
Plug 'LumaKernel/ddc-file'

" Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

Plug 'christoomey/vim-tmux-navigator'
Plug 'preservim/vimux'

Plug 'editorconfig/editorconfig-vim'
" Plug 'tyru/caw.vim'
Plug 'numToStr/Comment.nvim'
Plug 'tpope/vim-surround'
Plug 'thinca/vim-qfreplace'
" Plug 'preservim/nerdtree'
Plug 'terryma/vim-expand-region'
Plug 'ConradIrwin/vim-bracketed-paste'

Plug 'tpope/vim-dispatch'
" Plug 'vim-test/vim-test'
Plug 'yoann9344/vim-test', { 'branch': 'patch-1' }
Plug 'nathanaelkane/vim-indent-guides'
Plug 'haya14busa/vim-asterisk'
Plug 'mopp/autodirmake.vim'
Plug 'thinca/vim-zenspace'
Plug 'mhinz/vim-grepper'
Plug 'tyru/open-browser.vim'
Plug 'ykpythemind/toggle-term'
Plug 'dhruvasagar/vim-zoom'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-localrc'
Plug 'skanehira/qfopen.vim'
Plug 'simeji/winresizer'

" Git
Plug 'rhysd/git-messenger.vim'
Plug 'mhinz/vim-signify'

let gina = $VIM_GINA_ORIGINAL != "" ? 'lambdalisue/gina.vim' : '/Users/ykpythemind/git/github.com/ykpythemind/gina.vim'
Plug gina

" lang
Plug 'slim-template/vim-slim'
Plug 'mattn/vim-goimports'
Plug 'leafgarland/typescript-vim'
Plug 'rust-lang/rust.vim'
" view
" Plug 'itchyny/lightline.vim'
Plug 'w0ng/vim-hybrid'
Plug 'cocopon/iceberg.vim'
call plug#end()

" ddc
call ddc#custom#patch_global('sources', [
\ 'nvim-lsp',
\ 'around',
\ 'buffer',
\ 'file',
\ ])
" call ddc#custom#patch_global('completionMenu', 'pum.vim')

call ddc#custom#patch_global('sourceOptions', {
\  '_': {
\    'matchers': ['matcher_fuzzy'],
\    'sorters': ['sorter_fuzzy'],
\    'converters': ['converter_fuzzy']
\  },
\ 'buffer': {'mark': 'B'},
\ 'around': {'mark': 'A'},
\ 'nvim-lsp': {
\   'mark': 'lsp',
\   'forceCompletionPattern': '\.\w*|:\w*|->\w*',
\   'minAutoCompleteLength': 1
\ },
\ 'file': {
\   'mark': 'File',
\   'isVolatile': v:true,
\   'forceCompletionPattern': '\S/\S*',
\ },
\})

call ddc#custom#patch_global('sourceParams', {
\ 'around': {'maxSize': 500},
\ 'buffer': {
\   'requireSameFiletype': v:false,
\   'limitBytes': 5000000,
\   'fromAltBuf': v:true,
\   'forceCollect': v:true,
\ },
\ })

call ddc#custom#patch_filetype(['typescript', 'go', 'rust'], 'sources', ['nvim-lsp'])

inoremap <silent><expr> <TAB>
\ pumvisible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#manual_complete()

inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'
call ddc#enable()

" prettier
" let g:prettier#autoformat = 1
" let g:prettier#autoformat_require_pragma = 0
" let g:prettier#exec_cmd_async = 1
" let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat = 0
let g:prettier#autoformat_require_pragma = 0
let g:prettier#exec_cmd_async = 1
let g:prettier#quickfix_enabled = 0

" quickrun
let g:quickrun_no_default_key_mappings = 1
nmap <Leader>r <Plug>(quickrun)
vmap <Leader>r <Plug>(quickrun)

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
noremap <C-g>p :Gina push<cr>
nnoremap <C-g>s :Gina status -v --opener=split --group=git<cr>
nnoremap <C-g>c :Gina commit -v --opener=split --group=git<cr>
nnoremap <C-g>l :Gina log<cr>
nnoremap <C-g>d :Gina diff<cr>
nnoremap <C-g>D :Gina diff

"color
" colorscheme hybrid
colorscheme iceberg
hi QuickFixLine ctermbg=none ctermfg=none
hi MatchParen guifg=none guibg=#585858

" colorscheme より後におく
let s:true_color_enabled = $TERM_PROGRAM ==# 'iTerm.app' || $TERM_PROGRAM ==# 'alacritty' " || $COLORTERM ==# 'truecolor'
if s:true_color_enabled
  set termguicolors
endif

set termguicolors

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " 文字色
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " 背景色

set background=dark
" hi Normal ctermfg=252 ctermbg=16 guifg=#c5c8c6 guibg=#1d1f21

" vim-asterisk
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)

" expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Lightline
function! LightlineFilename()
  return expand('%:t') !=# '' ? expand('%') : '[---]'
endfunction
let g:lightline = {
  \ 'colorscheme': 'iceberg',
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

" other
set shell=zsh
lang en_US.UTF-8 " paste issue
autocmd FileType help nnoremap <buffer> q <C-w>c
nnoremap T :TestNearest<CR>
nnoremap <Leader>tt :TestNearest<CR>
nnoremap <Leader>tl :TestLast<CR>
let test#neovim#term_position = "botright 30"
if has('nvim')
  let test#strategy = 'harpoon'
  let g:test#harpoon_stay_here = 1
else
  let test#strategy = 'vimux'
end

nmap <Leader>b <Plug>(openbrowser-smart-search)
vmap <Leader>b <Plug>(openbrowser-smart-search)
command! CopyCurrentPath :let @+ = expand('%')
command! Pr exe "!git brws --pr"
command! Code :call Opencode()
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

" makeprg
autocmd Filetype typescript setlocal makeprg=yarn\ run\ --silent\ tsc
autocmd Filetype typescriptreact setlocal makeprg=yarn\ run\ --silent\ tsc

" coc-prettier
" nmap <leader>f :Prettier<CR>
" command! -nargs=0 Prettier :CocCommand prettier.formatFile
"
" let g:coc_global_extensions = ['coc-prettier']

if has('mac')
  " set ttimeoutlen=1
  let g:imeoff = 'osascript -e "tell application \"System Events\" to key code 102"'
  " augroup MyIMEGroup
  "   autocmd!
  "   autocmd InsertLeave * :call system(g:imeoff)
  " augroup END
  "noremap <silent> <ESC> <ESC>:call system(g:imeoff)<CR>
  inoremap <silent> <C-c> <ESC>:call system(g:imeoff)<CR>
endif
