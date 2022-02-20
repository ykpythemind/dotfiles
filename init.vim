set runtimepath^=~/.vim runtimepath+=~/.vim/after

" deno debug
" set runtimepath^=~/deno_altr runtimepath+=~/ghpr-blame.denops
" let g:denops#debug = 1
" let g:denops#trace = 1

let &packpath = &runtimepath

source ~/.vimrc

set inccommand=split
" set pumblend=10

set guicursor=n-c-v:block-nCursor,i-ci:blinkon0-blinkwait0-blinkoff0

autocmd TermOpen * setlocal nonumber

" nnoremap <C-e> <cmd>Telescope buffers<CR>
" nnoremap L <cmd>Telescope live_grep<cr>
" nnoremap <leader>h <cmd>lua require('telescope.builtin').oldfiles({ cwd_only = true })<cr>

" formatter.nvim
nnoremap <leader>f :Format<CR>

call deoppet#initialize()
" imap <C-l> <Plug>(deoppet_expand)
imap <expr> <C-l> deoppet#expandable() ? '<Plug>(deoppet_expand)' : ''
smap <expr> <C-l> deoppet#expandable() ? '<Plug>(deoppet_expand)' : ''
imap <Right>  <Plug>(deoppet_jump_forward)
imap <Left>  <Plug>(deoppet_jump_backward)
smap <Right>  <Plug>(deoppet_jump_forward)
smap <Left>  <Plug>(deoppet_jump_backward)
call deoppet#custom#option('snippets', map(globpath(&runtimepath, 'snippets', 1, 1),
  \ { _, val -> { 'path': val } }))

call deoppet#custom#option('ft_snippets_map',
      \ {'typescriptreact': ['typescript', 'javascript']},
      \ {'typescript': ['typescript', 'javascript']}
 \ )

" nnoremap H <cmd>HopChar2<cr>

lua <<LUA

local formatterConfig = {}

local prettierConfig = function()
  return {
    exe = "prettier",
    args = {'--config-precedence','prefer-file', "--stdin-filepath", vim.fn.shellescape(vim.api.nvim_buf_get_name(0))},
    stdin = true
  }
end
local commonFT = {
  "javascript", "javascriptreact", "typescript", "typescriptreact",
  "ruby",
}
for _, ft in ipairs(commonFT) do
  formatterConfig[ft] = { prettierConfig }
end
require('formatter').setup({ filetype = formatterConfig })

require('Comment').setup()

require'hop'.setup()

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true, disable = { 'lua', 'toml', 'c_sharp', 'vue' }
  }
}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
--local servers = { 'solargraph', 'rust_analyzer', 'tsserver', 'gopls' }
--for _, lsp in pairs(servers) do
--  require('lspconfig')[lsp].setup {
--    on_attach = on_attach,
--    flags = {
--      -- This will be the default in neovim 0.7+
--      debounce_text_changes = 150,
--    }
--  }
--end

local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
    local opts = {
      flags = {
        -- This will be the default in neovim 0.7+
        debounce_text_changes = 150,
      }
    }
    opts.on_attach = on_attach

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function will take the provided server configuration and decorate it with the necessary properties
    -- before passing it onwards to lspconfig.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)
LUA

lua << TELESCOPE
local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },

    layout_strategy = "horizontal",

    layout_config = {
      width = 0.95,
      height = 0.85,
      prompt_position = "bottom",
      horizontal = { preview_width = 0.5, },
      vertical = { width = 0.9, height = 0.95, preview_height = 0.5, },
    },

    sorting_strategy = "descending",
  },
  pickers = {
    buffers = { ignore_current_buffer = true, sort_lastused = true, },
  }
}

function launch_filer()
  local opts = {
    shorten_path = false,
    layout_config = {},
  }
  local ok = pcall(require'telescope.builtin'.git_files, opts)
  if not ok then require'telescope.builtin'.find_files(opts) end
end

vim.api.nvim_set_keymap('n', '<C-p>', '<CMD>lua launch_filer()<CR>', {noremap = true, silent = true})
TELESCOPE
