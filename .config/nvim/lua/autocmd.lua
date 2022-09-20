-- remove all trailing whitespace on save
--vim.api.nvim_create_autocmd({"BufWritePre"}, {
--  pattern = "*",
--  command = "%s/\\s\\+$//e"
--})

vim.api.nvim_create_autocmd({"BufEnter"}, {
  pattern = "*",
  command = "setlocal fo-=orc"
})

-- vim.api.nvim_create_autocmd({"FocusGained"}, { command = [[:checktime]] })
-- okasii
