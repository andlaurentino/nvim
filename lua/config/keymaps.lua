vim.g.mapleader = " "

-- Prevent clear the clipboard after Past
vim.cmd("xnoremap <expr> p 'pgv\"'.v:register.'y`>'")
vim.cmd("xnoremap <noremap <expr> P 'Pgv\"'.v:register.'y`>'")

-- Spliting
vim.keymap.set("n", "|", vim.cmd.vsplit, { desc="Vertical split" })
vim.keymap.set("n", "-", vim.cmd.split, { desc="Horizontal split" })

-- Move one line on normal
-- vim.keymap.set("n", "˚", function() vim.cmd.m("-2") end, { desc="Go next buffer" })
-- vim.keymap.set("n", "∆", function() vim.cmd.m("+1") end, { desc="Go next buffer" })

-- Move selected lines on visual
-- vim.keymap.set("v", "˚", ":m '<-2<CR>gv=gv")
-- vim.keymap.set("v", "∆", ":m '>+1<CR>gv=gv")

-- Move cursor on Windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Resize Windows
vim.keymap.set("n", "<C-S-Left>", "<cmd>vertical resize -5<CR>")
vim.keymap.set("n", "<C-S-Right>", "<cmd>vertical resize +5<CR>")
vim.keymap.set("n", "<C-S-Up>", "<cmd>resize +5<CR>")
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize -5<CR>")

-- Navigate buffers / tabs
vim.keymap.set("n", "<TAB>", "<cmd>bn!<CR>", { desc="Go next buffer" })
vim.keymap.set("n", "<S-TAB>", "<cmd>bp!<CR>", { desc="Go previous buffer" })

-- Indent keeping the visual mode
vim.keymap.set("v", "<tab>", ">gv", { desc="Indent forward" })
vim.keymap.set("v", "<s-tab>", "<gv", { desc="Indent backwar" })
vim.keymap.set("v", ">", ">gv", { desc="Indent forward" })
vim.keymap.set("v", "<", "<gv", { desc="Indent backward" })

-- Close buffer / tab
vim.keymap.set("n", "<C-w>", "<cmd>bd<CR>")

-- Save file
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc="Save buffer" })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>", { desc="Save buffer" })
vim.keymap.set("n", "<Leader>w", "<cmd>w<CR>", { desc="Save buffer" })

-- Quit
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc="Quit" })

-- Source file
-- vim.keymap.set("n", "<leader><leader>", "<cmd>so<CR>")

-- Add new empty lines
vim.keymap.set("n", "<S-enter>", "O<Esc>")
vim.keymap.set("n", "<enter>", "o<Esc>")
