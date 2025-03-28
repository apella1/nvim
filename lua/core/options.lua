-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- General settings
vim.wo.number = true
vim.wo.relativenumber = true

-- Tab settings
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4

-- Color settings
vim.opt.termguicolors = true

-- Format on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    command = "FormatWriteLock",
})
