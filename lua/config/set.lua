-- Indenting
vim.o.tabstop = 4       -- A TAB character looks like 4 spaces
vim.o.expandtab = false -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4   -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4    -- Number of spaces inserted when indenting
vim.opt.wrap = false
vim.opt.smartindent = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Use the clipboard to yake and paste
vim.cmd("set clipboard=unnamedplus")

vim.opt.updatetime = 50

-- Line numbers
vim.opt.number = false
vim.opt.relativenumber = true
