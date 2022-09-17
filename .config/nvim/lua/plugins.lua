vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
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

      vim.keymap.set('n', '<C-p>', ':lua launch_filer()<CR>', { noremap = true, silent = false })
      vim.keymap.set('n', '<C-e>', '<cmd>Telescope buffers<CR>', { noremap = true, silent = false })
      vim.keymap.set('n', '<Leader>g', '<cmd>Telescope grep_string<CR>', { noremap = true, silent = false })
      vim.keymap.set('n', '<Leader>y', ":lua require'telescope.builtin'.registers{}<CR>", { noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>h', ":lua require'telescope.builtin'.oldfiles({ cwd_only = true })<CR>", { noremap = true, silent = true })
      -- vim.keymap.set('n', '<C-g>l', ":lua require'telescope.builtin'.git_bcommits{}<CR>", { noremap = true, silent = true })
    end
  }
end)
