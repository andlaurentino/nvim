vim.g.mapleader = " "


vim.keymap.set("n", "|", vim.cmd.vsplit)
vim.keymap.set("n", "-", vim.cmd.split)

-- Move one line
vim.keymap.set("n", "˚", function () vim.cmd.m("-2") end)
vim.keymap.set("n", "∆", function () vim.cmd.m("+1") end)

-- Move visual
vim.keymap.set("v", "˚", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "∆", ":m '>+1<CR>gv=gv")

-- Move cursor on buffers
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<TAB>", ":bn!<CR>")
vim.keymap.set("n", "<S-TAB>", ":bp!<CR>")

vim.keymap.set("n", "<C-w>", ":bd<CR>")

-- Use the clipboard to yake and paste
vim.cmd("set clipboard=unnamedplus")
