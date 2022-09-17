vim.g.mapleader = ' '

vim.keymap.set('n', 'ZZ', '<NOP>', {noremap = true, silent = true})
vim.keymap.set('n', 'ZQ', '<NOP>', {noremap = true, silent = true})
vim.keymap.set('n', 'Q', '<NOP>', {noremap = true, silent = true})
vim.keymap.set('', 'R', '<NOP>', {noremap = true, silent = true})
vim.keymap.set('n', ';', ':', {noremap = true})

--nnoremap Y y$

vim.keymap.set('n', '/', '/\\v', {noremap = true})
vim.keymap.set('n', '?', '?\\v', {noremap = true})

vim.keymap.set('i', '<C-j>', '<Esc>', {noremap = true, silent = true})
vim.keymap.set('i', '<C-b>', '<Left>', {noremap = true, silent = true})
vim.keymap.set('i', '<C-f>', '<Right>', {noremap = true, silent = true})
vim.keymap.set('i', '<C-k>', '<C-o>D', {noremap = true, silent = true})
vim.keymap.set('i', '<C-a>', '<C-o>^', {noremap = true, silent = true})
vim.keymap.set('i', '<C-e>', '<C-o>$', {noremap = true, silent = true})

vim.keymap.set('c', '<C-f>', '<Right>', {noremap = true, silent = true})
vim.keymap.set('c', '<C-b>', '<Left>', {noremap = true, silent = true})
vim.keymap.set('c', '<C-a>', '<C-b>', {noremap = true, silent = true})
vim.keymap.set('c', '<C-e>', '<C-e>', {noremap = true, silent = true})
vim.keymap.set('c', '<C-v>', '<C-f>', {noremap = true, silent = true})
vim.keymap.set('c', '<C-x>', "<c-r>=expand('%:p')", {noremap = true})
vim.keymap.set('c', '<C-d>', "<c-r>=expand('%:p:h')", {noremap = true})

vim.keymap.set('n', '<Esc><Esc>', ':noh<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>l', ':noh<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>o', 'o<Esc>', { noremap = true, silent = false })

vim.keymap.set('n', '!', ':<C-f>', { noremap = true })
vim.keymap.set('n', 'M', 'mM', { noremap = true, silent = true })
vim.keymap.set('n', 'gM', '`M', { noremap = true, silent = true })
vim.keymap.set('n', '<C-y>', '<C-^>', { noremap = true, silent = true })

-- grep
vim.keymap.set('n', 'sg', ':<C-u>%s/\\v//g<Left><Left><Left>', { noremap = true })
vim.keymap.set('v', 'sg', ':s/\\v//g<Left><Left><Left>', { noremap = true })
vim.keymap.set('n', 's', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('v', 's', '<Nop>', { noremap = true, silent = true })

vim.keymap.set('v', 'y', 'y`]', { noremap = true, silent = true })
vim.keymap.set('n', 'x', '"_x', { noremap = true })
vim.keymap.set('x', 'p', '"_dP', { noremap = true })

vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true })

vim.keymap.set('v', '>', '>gv', { noremap = true })
vim.keymap.set('v', '<', '<gv', { noremap = true })

--" quickfix
--nnoremap <C-n> :Cnext<CR>
--nnoremap <C-a> :Cprev<CR>
--" In the quickfix window, <CR> is used to jump to the error under the cursor, so undefine the mapping there.
--autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
--autocmd BufReadPost quickfix nnoremap <buffer><silent> <C-o> :colder<CR>
--autocmd BufReadPost quickfix nnoremap <buffer><silent> <C-i> :cnewer<CR>
--command! Cnext try | cnext | catch | cfirst | catch | endtry
--command! Cprev try | cprev | catch | clast | catch | endtry


vim.keymap.set('g', '<ESC>', '<C-\><C-n>', { noremap = true, silent = true })
