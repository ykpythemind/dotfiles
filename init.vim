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

nnoremap <C-e> <cmd>Telescope buffers<CR>
nnoremap L <cmd>Telescope live_grep<cr>
nnoremap <leader>h <cmd>lua require('telescope.builtin').oldfiles({ cwd_only = true })<cr>

nnoremap H <cmd>HopChar2<cr>

lua <<LUA
require('Comment').setup()

require'hop'.setup()

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = { 'lua', 'toml', 'c_sharp', 'vue' }
  }
}
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
