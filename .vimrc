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
set ttyfast
" set lazyredraw
set updatetime=300
set shortmess+=c " coc
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
cnoremap <C-v> <C-f>a
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
nnoremap dD "_dd
vnoremap D "_d

nnoremap <C-s> :w<CR>

nnoremap <C-l> :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><C-l>

nnoremap <silent> <Space>o :<C-u>for i in range(1, v:count1) \| call append(line('.'),   '') \| endfor<CR>
nnoremap <silent> <Space>O :<C-u>for i in range(1, v:count1) \| call append(line('.')-1, '') \| endfor<CR>

" quickfix
nnoremap <C-n> :Cnext<CR>
nnoremap <C-m> :Cprev<CR>
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

" term
autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif

tnoremap <ESC> <C-\><C-n>
" Easier time when pasting content in terminal mode with <C-v> : https://github.com/vimlab/split-term.vim/blob/a4e28cab77ad07fc8a0ebb62a982768c02eb287c/plugin/split-term.vim#L41
tnoremap <buffer> <expr> <C-v> '<C-\><C-N>pi'
nnoremap <C-t> :call ToggleMainTerm()<CR>
tnoremap <C-t> <C-\><C-n>:call ToggleMainTerm()<CR>
nnoremap <Leader><C-t> :call HideMainTerm()<CR>

" buffer
" nnoremap <C-k> :bnext<CR>
" nnoremap <C-j> :bprevious<CR>

" Plugin
call plug#begin('~/.vim/plugged')
Plug '~/playground/codesearch'

" Plug 'cohama/lexima.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc.nvim', {'branch': 'release', 'commit': 'ad1793dce0a59afcf8b324b45a1168c032deb162'}
Plug 'thinca/vim-qfreplace'
Plug 'preservim/nerdtree'
Plug 'mhinz/vim-grepper'
Plug 'terryma/vim-expand-region'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-test/vim-test'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'haya14busa/vim-asterisk'
Plug 'mopp/autodirmake.vim'
Plug 'thinca/vim-zenspace'
Plug 'Asheq/close-buffers.vim'
Plug 'kana/vim-altr'
Plug 'dyng/ctrlsf.vim'
if has('nvim')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
endif
Plug 'ReekenX/vim-rename2'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-localrc'
Plug 'wincent/ferret'
Plug 'tyru/capture.vim'
Plug 'haya14busa/vim-edgemotion'
" Git
Plug 'rhysd/git-messenger.vim'
Plug 'mhinz/vim-signify', {'branch': 'master', 'commit': 'd80e507c8ba31d7d071'} " https://github.com/mhinz/vim-signify/issues/366
Plug 'lambdalisue/gina.vim'
Plug 'rhysd/ghpr-blame.vim'
" lang
Plug 'slim-template/vim-slim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" view
Plug 'itchyny/lightline.vim'
Plug 'w0ng/vim-hybrid'
Plug 'romainl/vim-dichromatic'
Plug 'rhysd/vim-color-spring-night'
call plug#end()
source $VIMRUNTIME/macros/matchit.vim

nnoremap <Leader>s :CodeSearch<cr>

" edgemotion
map <C-j> <Plug>(edgemotion-j)
map <C-k> <Plug>(edgemotion-k)

let g:ctrlsf_backend = 'rg'
nnoremap ,f :CtrlSF<Space>
nnoremap ,f :CtrlSF<Space>
nnoremap ,F :CtrlSFToggle<CR>

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
nnoremap <C-H> :History<CR>
nnoremap <C-e> :Buffers<CR>
nnoremap L :BLines<CR>
nnoremap <Leader>L :Lines<CR>
let g:fzf_preview_window = []

" golang
let g:go_fmt_autosave = 0 " 0 == disable: coc.nvimを壊す
let g:go_list_type = "quickfix"
let g:go_def_mode='gopls'
let g:go_def_mapping_enabled = 0
let g:go_gorename_command = "gopls"
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" git
let g:git_messenger_date_format = "%Y/%m/%d %X"
nmap <C-g>m <Plug>(git-messenger)

let g:ghpr_github_auth_token = $GITHUB_TOKEN
noremap <C-g>b :Gina browse :
nnoremap <C-g>s :Gina status --opener=split --group=git<cr>
nnoremap <C-g>c :Gina commit --opener=split --group=git<cr>
nnoremap <C-g>d :Gina diff

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

nnoremap <silent> <Leader>cd :<C-u>CocList diagnostics<cr>
nnoremap <silent> <Leader>cf :<C-u>CocFix<cr>
let g:coc_disable_transparent_cursor= 1 " https://github.com/neoclide/coc.nvim/issues/1775

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
let s:true_color_enabled = $TERM_PROGRAM ==# 'iTerm.app' || $TERM_PROGRAM ==# 'alacritty'
if s:true_color_enabled
  set termguicolors
endif

" colorscheme dichromatic
" colorscheme spring-night
" hi String ctermfg=166 guifg=#d75f00
" hi Normal ctermfg=250 guifg=#f0f5f2
" hi Search ctermfg=250 ctermbg=237 guifg=#c5c8c6 guibg=#373b41
colorscheme hybrid
hi Normal ctermbg=0 guibg=#000000
hi QuickFixLine ctermbg=none ctermfg=none
hi MatchParen guifg=none guibg=#585858

" vim-asterisk
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)

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

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" nerdtree
noremap - :NERDTreeToggle<CR>
noremap = :NERDTreeFind<CR>
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.DS_Store$', '\.git$'] " ignore files in nerd tree
let NERDTreeQuitOnOpen = 1
let g:NERDTreeWinSize=50

" Lightline
function! LightlineFilename()
  return expand('%:t') !=# '' ? expand('%') : '[---]'
endfunction
let g:lightline = {
  \'active': {
  \  'left': [
  \    ['mode', 'paste'],
  \    ['readonly', 'filename', 'modified'] ],
  \ 'right': [
  \            [ 'filetype', 'coc' ] ]
  \},
  \'component_function': {
    \   'filename': 'LightlineFilename',
    \   'gitbranch': 'gina#component#repo#branch',
    \   'coc': 'coc#status'
  \},
  \'mode_map': { 'n': 'N', 'i': 'I', 'v': 'V' },
  \'tabline': { 'left': [['gitbranch', 'tabs']], 'right': [] }
\ }
let g:lightline.colorscheme = 'ayu_dark'

" lexima
" let g:lexima_enable_endwise_rules = 0 " disable

inoremap '' ''<Left>
inoremap "" ""<Left>
inoremap [] []<Left>
inoremap () ()<Left>
inoremap {} {}<Left>
inoremap `` ``<Left>
inoremap \|\| \|\|<Left>
inoremap `3<Enter> ```<Enter>```<Left><Left><Left><Left>

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
let test#neovim#term_position = "botright 30"
let test#strategy = 'neovim'

command! CopyCurrentPath :let @+ = expand('%')

command! Pr exe "!git brws --pr"


function! HideMainTerm()
  let bufnum = get(s:, 'terminal_buffer', -1)
  if bufexists(bufnum)
    silent execute bufwinnr(bufnum) . "hide"
  endif
endfunction

function! ToggleMainTerm()
  if bufnr('') == get(s:, 'terminal_buffer', -1)
    call LeaveMainTerm()
  else
    call EnterMainTerm()
  endif
endfunction

function! s:NewMainTermWin()
  bot new
  exec 'resize ' . get(g:, 'switch_term_height', 20)
  call setbufvar(bufnr(''), '&buflisted', 0)
endfunction

function! EnterMainTerm()
  let l:tid = get(s:, 'terminal_id', -1)
  let s:previous_window_before_term = win_getid()

  if !win_gotoid(tid)
    " show hidden buffer
    if bufexists(get(s:, 'terminal_buffer', -1))
      call s:NewMainTermWin()
      exec 'buffer ' . s:terminal_buffer
      startinsert
      let s:terminal_id = win_getid()
      return
    end

    " new term
    call s:NewMainTermWin()
    term
    startinsert
    call setbufvar(bufnr(''), '&buflisted', 0)
    let s:terminal_buffer = bufnr('')
    let s:terminal_id = win_getid()
  endif
endfunction

function! LeaveMainTerm()
  hide
  let prev = get(s:, 'previous_window_before_term', -1)
  call win_gotoid(prev)
endfunction
