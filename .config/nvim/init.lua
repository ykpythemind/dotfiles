require 'base'
require 'keymap'
require 'plugins'
require 'autocmd'

vim.keymap.set('n', '*', '<Plug>(asterisk-z*)')
vim.keymap.set('v', 'v', '<Plug>(expand_region_expand)')

function launch_filer()
  local opts = {
    shorten_path = false,
    layout_config = {},
  }
  local ok = pcall(require'telescope.builtin'.git_files, opts)
  if not ok then require'telescope.builtin'.find_files(opts) end
end

vim.keymap.set('n', '<C-p>', ':lua launch_filer()<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<C-e>', '<cmd>Telescope buffers<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<Leader>g', '<cmd>Telescope grep_string<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<Leader>y', ":lua require'telescope.builtin'.registers{}<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>h', ":lua require'telescope.builtin'.oldfiles({ cwd_only = true })<CR>", { noremap = true, silent = true })

vim.keymap.set('n', '-', '<cmd>NERDTreeToggle<CR>', { noremap = true })
vim.keymap.set('n', '=', '<cmd>NERDTreeFind<CR>', { noremap = true })

vim.cmd("colorscheme kanagawa")

-- 1. LSP Sever management
require('mason').setup()
require('mason-lspconfig').setup_handlers({ function(server)
  local opt = {
    -- -- Function executed when the LSP server startup
    -- on_attach = function(client, bufnr)
    --   local opts = { noremap=true, silent=true }
    --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    --   vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)'
    -- end,
    capabilities = require('cmp_nvim_lsp').update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )
  }
  require('lspconfig')[server].setup(opt)
end })

-- 2. build-in LSP function
-- keyboard shortcut
vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
-- Reference highlight
vim.cmd [[
set updatetime=500
highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
augroup lsp_document_highlight
  autocmd!
  autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
  autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
augroup END
]]

-- 3. completion (hrsh7th/nvim-cmp)
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
})

local null_ls = require("null-ls")

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.formatting()<CR>")

      -- format on save
      -- vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")
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


nnoremap <C-n> :Cnext<CR>
nnoremap <C-a> :Cprev<CR>
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
autocmd BufReadPost quickfix nnoremap <buffer><silent> <C-o> :colder<CR>
autocmd BufReadPost quickfix nnoremap <buffer><silent> <C-i> :cnewer<CR>
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry

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
]])
