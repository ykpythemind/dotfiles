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
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end
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
      vim.keymap.set('n', '-', '<cmd>NERDTreeToggle<CR>', { noremap = true })
      vim.keymap.set('n', '=', '<cmd>NERDTreeFind<CR>', { noremap = true })

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

  use {
    'terryma/vim-expand-region',
    config = function()
      vim.keymap.set('v', 'v', '<Plug>(expand_region_expand)', { noremap = true })
    end
  }

  use 'ConradIrwin/vim-bracketed-paste'
  use {
    'vim-test/vim-test',
    config = function()
      vim.keymap.set('n', '<Leader>tt', ':TestNearest<CR>', { noremap = true })
      vim.keymap.set('n', '<Leader>tl', ':TestLast<CR>', { noremap = true })
    end
  }

  use {
    'haya14busa/vim-asterisk',
    config = function()
      vim.keymap.set('n', '*', '<Plug>(asterisk-z*)')
    end
  }

  use 'mopp/autodirmake.vim'
  use 'thinca/vim-zenspace'
  use {
    'mhinz/vim-grepper',
    config = function()
      vim.cmd([[
        let g:grepper = {
        \ 'tools': ['rg', 'git'],
        \ 'rg': { 'grepprg': 'rg --hidden --vimgrep' },
        \}
      ]])

      vim.g.grepper.highlight = 1
      vim.g.grepper.switch = 0

      vim.keymap.set('n', 'F', ':Grepper -tool rg<CR>', { noremap = true })
      vim.keymap.set('n', '<Leader>F', ':Grepper -tool rg -buffer<CR>', { noremap = true })
      vim.keymap.set('x', 'F', '<Plug>(GrepperOperator)')
    end
  }

  use {
    'tyru/open-browser.vim',
    config = function()
      vim.keymap.set('n', '<Leader>b', '<Plug>(openbrowser-smart-search)')
      vim.keymap.set('v', '<Leader>b', '<Plug>(openbrowser-smart-search)')
    end
  }

  use {
    'thinca/vim-quickrun',
    config = function()
      vim.g.quickrun_no_default_key_mappings = 1
      vim.keymap.set('n', '<Leader>r', '<Plug>(quickrun)')
    end
  }
  use 'thinca/vim-localrc'


  use {
    'rhysd/git-messenger.vim',
    config = function()
      vim.g.git_messenger_date_format = "%Y/%m/%d %X"
      vim.keymap.set('n', '<C-g>m', '<Plug>(git-messenger)')
    end
  }

  use 'itchyny/vim-gitbranch'

  use { 
    'mhinz/vim-sayonara',
    config = function()
      vim.keymap.set('n', '<M-w>', ':Sayonara<CR>', { noremap = true })
    end
  }

  use 'slim-template/vim-slim'
  use 'mattn/vim-goimports'
  use 'leafgarland/typescript-vim'
  use 'rust-lang/rust.vim'
  use 'hashivim/vim-terraform'

  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require'nvim-web-devicons'.setup()
    end
  }
end)
