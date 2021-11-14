set runtimepath^=~/.vim runtimepath+=~/.vim/after

" deno debug
set runtimepath^=~/deno_altr
let g:denops#debug = 1
" let g:denops#trace = 1

let &packpath = &runtimepath

source ~/.vimrc

set inccommand=split
" set pumblend=10

autocmd TermOpen * setlocal nonumber

nnoremap <C-e> <cmd>Telescope buffers<CR>
nnoremap L <cmd>Telescope live_grep<cr>
nnoremap <leader>h <cmd>lua require('telescope.builtin').oldfiles({ cwd_only = true })<cr>

set guicursor=n-c-v:block-nCursor,i-ci:blinkon0-blinkwait0-blinkoff0

highlight LspDiagnosticsSignError ctermbg=9 ctermfg=15
highlight LspDiagnosticsSignHint ctermbg=142 ctermfg=15

" nvim-tree (must before 'nvim-tree'.setup() )
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 0,
    \ 'files': 0,
    \ 'folder_arrows': 0,
    \ }
nnoremap - :NvimTreeToggle<CR>
nnoremap = :NvimTreeFindFileToggle<CR>

lua <<LUA
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require'nvim-tree'.setup({
  view = {
    mappings = {
      custom_only = false,
      list = {
        { key = "-", cb = tree_cb("close") },
      }
    }
  }
})

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
LUA

lua << TELESCOPE
local actions = require('telescope.actions')
local themes = require("telescope.themes")

require('telescope').setup{
  defaults = {
    winblend = 0,

    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-u>"] = false,
        ["<c-a>"] = { "<home>", type = "command" },
        ["<c-e>"] = { "<end>", type = "command" },
      },
    },

    layout_strategy = "horizontal",

    layout_config = {
      width = 0.95,
      height = 0.85,
      prompt_position = "bottom",

      horizontal = {
        preview_width = 0.5,
      },

      vertical = {
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },
    },

    selection_strategy = "reset",
    sorting_strategy = "descending",
  },
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

lua << LSP
require'lspconfig'.gopls.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.solargraph.setup{}
--require'lspconfig'.denols.setup{}

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  require "lsp_signature".on_attach() -- https://github.com/ray-x/lsp_signature.nvim

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', 'g[', '<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { focusable = false } })<CR>', opts)
  buf_set_keymap('n', 'g]', '<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { focusable = false } })<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)

-- show line diagostics under cursor
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'gopls', 'tsserver', 'solargraph' } -- 'denols'
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
LSP

lua << SSSS
-- https://phelipetls.github.io/posts/async-make-in-nvim-with-lua/
function asyncMake()
  local lines = {""}
  local winnr = vim.fn.win_getid()
  local bufnr = vim.api.nvim_win_get_buf(winnr)

  local makeprg = vim.api.nvim_buf_get_option(bufnr, "makeprg")
  if not makeprg then return end

  local cmd = vim.fn.expandcmd(makeprg)

  local function on_event(job_id, data, event)
    if event == "stdout" or event == "stderr" then
      if data then
        vim.list_extend(lines, data)
      end
    end

    if event == "exit" then
      vim.fn.setqflist({}, " ", {
        title = cmd,
        lines = lines,
        efm = vim.api.nvim_buf_get_option(bufnr, "errorformat")
      })
      vim.api.nvim_command("doautocmd QuickFixCmdPost")
    end
  end

  local job_id =
    vim.fn.jobstart(
    cmd,
    {
      on_stderr = on_event,
      on_stdout = on_event,
      on_exit = on_event,
      stdout_buffered = true,
      stderr_buffered = true,
    }
  )
end
SSSS

command! Make silent lua asyncMake()

nnoremap <leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>e :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <leader><leader> :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <leader>j :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <leader>k :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <leader>n :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <leader>m :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <leader>cu :lua require("harpoon.term").gotoTerminal(1)<CR>

lua << FORMATTER
--require("formatter").setup(
--  {
--    logging = true,
--    filetype = {
--      typescriptreact = {
--        function()
--          return {
--            exe = "prettier",
--            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
--            stdin = true
--          }
--        end
--      },
--      typescript = {
--        function()
--          return {
--            exe = "prettier",
--            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
--            stdin = true
--          }
--        end
--      },
--      javascript = {
--        function()
--          return {
--            exe = "prettier",
--            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
--            stdin = true
--          }
--        end
--      },
--      javascriptreact = {
--        function()
--          return {
--            exe = "prettier",
--            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
--            stdin = true
--          }
--        end
--      },
--      ruby = {
--        function()
--          return {
--            exe = "prettier",
--            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
--            stdin = true
--          }
--        end
--      },
--    }
--  }
--)
--vim.api.nvim_exec([[
--augroup FormatAutogroup
--  autocmd!
--  autocmd BufWritePost *.js,*.ts,*.jsx,*tsx FormatWrite
--augroup END
--]], true)

FORMATTER
" nnoremap <silent> <leader>f :Format<CR>
