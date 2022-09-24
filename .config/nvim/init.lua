require 'base'
require 'keymap'
require 'plugins'
require 'autocmd'
require 'lsp'

local null_ls = require("null-ls")

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.formatting()<CR>")
    end

    if client.server_capabilities.documentRangeFormattingProvider then
      vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>")
    end
  end,
})
local prettier = require("prettier")
prettier.setup({
  bin = 'prettier', -- or `'prettierd'` (v0.22+)
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
  ["null-ls"] = {
    condition = function()
      return prettier.config_exists({
        -- if `true`, checks `package.json` for `"prettier"` key
        check_package_json = false,
      })
    end,
    runtime_condition = function(params)
      -- return false to skip running prettier
      return true
    end,
    timeout = 5000,
  }
})

vim.cmd([[
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

nnoremap cp :let @+ = expand('%')<CR>
command! Code execute 'silent !code -r ' . getcwd() <bar> execute 'silent :!code -r ' . expand('%')

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

nnoremap <C-n> :Cnext<CR>
nnoremap <C-a> :Cprev<CR>
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
autocmd BufReadPost quickfix nnoremap <buffer><silent> <C-o> :colder<CR>
autocmd BufReadPost quickfix nnoremap <buffer><silent> <C-i> :cnewer<CR>
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry


function! MyTabLine()
  let s = ' ' . gitbranch#name() . ' '
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
      let s .= ' ' . bufname . ' ' " or pathshorten(bufname)
    endif
  endfor
  let s .= '%#TabLineFill#' " blank highlighting between the tabs and the righthand close 'X'
  let s .= '%T' " resets tab page number?
  let s .= '%=' " seperate left-aligned from right-aligned
  return s
endfunction
set tabline=%!MyTabLine()

set statusline=%<%f\ %m%h%r
set statusline+=%=%l/%L
set statusline+=\ %y
]])
