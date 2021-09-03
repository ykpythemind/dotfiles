set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source ~/.vimrc

set inccommand=split
set pumblend=10

autocmd TermOpen * setlocal nonumber

" https://github.com/junegunn/fzf.vim/issues/544
augroup fzfesc
au!
au TermOpen * tnoremap <Esc> <c-\><c-n>
au FileType fzf tunmap <Esc>
augroup end

set guicursor=n-c-v:block-nCursor,i-ci:blinkon0-blinkwait0-blinkoff0

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {
      'lua',
      'toml',
      'c_sharp',
      'vue',
    }
  }
}
EOF
