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

      -- vim.keymap.set('n', '<C-g>l', ":lua require'telescope.builtin'.git_bcommits{}<CR>", { noremap = true, silent = true })
      --
    end
  }

  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/vim-vsnip"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-buffer"

  use 'jose-elias-alvarez/null-ls.nvim'
  use 'MunifTanjim/prettier.nvim'

  use {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup{} end
  }

  use {
    "rebelot/kanagawa.nvim",
    config = function()
      vim.api.nvim_command('set termguicolors')
      vim.api.nvim_command('syntax enable')
    end
  }

  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }

  use {
    "preservim/nerdtree",
    config = function()
      vim.cmd([[
        let NERDTreeShowHidden=1
        let NERDTreeIgnore=['\.DS_Store$', '\.git$'] " ignore files in nerd tree
        let g:NERDTreeWinSize=50
        let NERDTreeMapQuit='='
      ]])
    end
  }

  use 'tpope/vim-surround'
  use 'thinca/vim-qfreplace'
  use 'terryma/vim-expand-region'
  use 'ConradIrwin/vim-bracketed-paste'
  use 'vim-test/vim-test'
  use 'haya14busa/vim-asterisk'
  use 'mopp/autodirmake.vim'
  use 'thinca/vim-zenspace'
  use 'mhinz/vim-grepper'
  use 'tyru/open-browser.vim'
  use 'thinca/vim-quickrun'
  use 'thinca/vim-localrc'
  use 'mhinz/vim-sayonara'
  use 'rhysd/git-messenger.vim'
  use 'itchyny/vim-gitbranch'
  use 'slim-template/vim-slim'
  use 'mattn/vim-goimports'
  use 'leafgarland/typescript-vim'
  use 'rust-lang/rust.vim'
  use 'hashivim/vim-terraform'

  use 'kyazdani42/nvim-web-devicons'
end)
