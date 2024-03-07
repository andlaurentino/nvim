vim.g.mapleader = " "

-- Spliting
vim.keymap.set("n", "|", vim.cmd.vsplit)
vim.keymap.set("n", "-", vim.cmd.split)

-- Move one line on normal
vim.keymap.set("n", "˚", function () vim.cmd.m("-2") end)
vim.keymap.set("n", "∆", function () vim.cmd.m("+1") end)

-- Move selected lines on visual
vim.keymap.set("v", "˚", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "∆", ":m '>+1<CR>gv=gv")

-- Move cursor on buffers
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Navigate buffers / tabs
vim.keymap.set("n", "<TAB>", ":bn!<CR>")
vim.keymap.set("n", "<S-TAB>", ":bp!<CR>")

-- Close buffer / tab
vim.keymap.set("n", "<C-w>", ":bd<CR>")

-- Save file
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>")
vim.keymap.set("n", "<Leader>w", ":w<CR>")

-- Open NvimTree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
