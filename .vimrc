filetype plugin indent on

syntax on

set nowrap

set hlsearch
set ignorecase
set smartcase

set autoindent

set ruler
set number
set list
set wildmenu
set showcmd

set shiftwidth=4
set softtabstop=4
set expandtab
set tabstop=4
set smarttab

set clipboard=unnamed

"シンタックスハイライト
syntax enable
set autoindent
set expandtab
set smarttab
set wrap

au BufNewFile,BufRead *.rb  set nowrap tabstop=2 shiftwidth=2

"行番号の色や現在行の設定
autocmd ColorScheme * highlight LineNr ctermfg=12
highlight CursorLineNr ctermbg=4 ctermfg=0
set cursorline
highlight clear CursorLine


"

"インクリメンタルサーチしない
set noincsearch
set wrapscan
set gdefault


"不可視文字の設定
set list
set listchars=tab:>-,eol:↲,extends:»,precedes:«,nbsp:%

"コマンドラインモードのファイル補完設定
set wildmode=list:longest,full

set showcmd

set clipboard=unnamed,autoselect

"カーソル移動で行をまたげるようにする
set whichwrap=b,s,h,l,<,>,~,[,]

"バックスペースを使いやすく
set backspace=indent,eol,start
set nrformats-=octal

set pumheight=10

"対応する括弧に一瞬移動
set showmatch
set matchtime=1
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する

set display=lastline


";;でノーマルモード
inoremap ;; <esc>


"rだけでリドゥ
nnoremap r <C-r>

"Yで行末までヤンク
nnoremap Y y$

"NERDTreeToggleをC-eで開く
nnoremap <silent><C-e> :NERDTreeToggle<CR>

"ペースト時に自動インデントで崩れるのを防ぐ
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif


"NeoBundle
"--------------------------

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif 

call neobundle#begin(expand('~/.vim/bundle'))
"NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Shougo/neoyank.vim'
NeoBundle 'Shougo/unite-outline.vim'
NeoBundle 'scrooloose/nerdtree'
"NeoBundle 'marijnh/tern_for_vim'
NeoBundle 'tpope/vim-rails'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'thinca/vim-ref'
NeoBundle 'mojako/ref-sources.vim'
NeoBundle 'mustardamus/jqapi'
NeoBundle 'tokuhirom/jsref'


call neobundle#end()

filetype plugin indent on

"let g:neocomplete#enable_at_startup = 1

" for JS 
let g:ref_jquery_doc_path = $HOME . '/.bundle/jqapi'
let g:ref_javascript_doc_path = $HOME . '/.bundle/jsref/htdocs'



" 挿入モードで開始する  
let g:unite_enable_start_insert=1
 
" 大文字小文字を区別しない  
let g:unite_enable_ignore_case = 1  
let g:unite_enable_smart_case = 1
 
" ESCキーを2回押すと終了する  
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>

au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

"history and yank ... neoyank.vim
let g:neoyank#limit = 1
let g:neoyank#file = 1
let g:neoyank#registers = 1

"prefix keyの設定
nmap <Space> [unite]

"スペースキーとaキーでカレントディレクトリを表示
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"スペースキーとfキーでバッファと最近開いたファイル一覧を表示
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer file_mru<CR>
"スペースキーとdキーで最近開いたディレクトリを表示
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
"スペースキーとbキーでバッファを表示
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
"スペースキーとrキーでレジストリを表示
nnoremap <silent> [unite]r :<C-u>Unite<Space>register<CR>
"スペースキーとhキーでヒストリ/ヤンクを表示
nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
"unite.vimを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
    " ESCでuniteを終了
    nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction"}}}



" NEOCOMPLACHE=================
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()


autocmd FileType javascript :set dictionary=$HOME/.vim/dict/javascript.dict,$HOME/.vim/dict/jQuery.dict



" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
""""""""""""""""""""""""""""""
