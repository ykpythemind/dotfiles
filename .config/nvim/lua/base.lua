vim.opt.autoread = true
vim.opt.hidden = true
vim.opt.scrolloff = 10
vim.api.nvim_command('set noswapfile')
vim.api.nvim_command('set nobackup')
vim.api.nvim_command('set nowritebackup')
vim.opt.mouse = 'a'

-- vim.opt.ttimeoutlen = 100

vim.opt.number = true
vim.opt.wrap = true
vim.opt.cursorline = true
vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wildmenu = true

vim.opt.cmdheight = 2
vim.opt.laststatus = 2
-- set display=lastline

vim.opt.backspace = 'indent,eol,start'

vim.opt.listchars = { tab = '>-', eol = '↲', extends = '»', precedes = '«', nbsp = '%', trail = '-' }
vim.opt.list = true

vim.opt.clipboard = vim.opt.clipboard + 'unnamedplus'

vim.opt.whichwrap = 'b,s,h,l,<,>,~,[,]'

vim.opt.completeopt = 'menuone,noinsert,noselect'

vim.o.signcolumn = "yes"

vim.opt.shiftwidth = 2
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.expandtab = true

--vim.opt.noerrorbells = true
--vim.opt.novisualbell = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.api.nvim_command('set undofile')
vim.api.nvim_command('set undodir=$HOME/.vim/undo')

vim.api.nvim_command('lang en_US.UTF-8')

vim.cmd("colorscheme kanagawa")
