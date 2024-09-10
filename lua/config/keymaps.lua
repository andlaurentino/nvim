vim.g.mapleader = " "

-- Prevent clear the clipboard after Past
vim.cmd("xnoremap <expr> p 'pgv\"'.v:register.'y`>'")
vim.cmd("xnoremap <noremap <expr> P 'Pgv\"'.v:register.'y`>'")

-- Spliting
vim.keymap.set("n", "|", vim.cmd.vsplit, { desc = "Vertical split" })
vim.keymap.set("n", "-", vim.cmd.split, { desc = "Horizontal split" })

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
vim.keymap.set("n", "<TAB>", "<cmd>bn!<CR>", { desc = "Go next buffer" })
vim.keymap.set("n", "<S-TAB>", "<cmd>bp!<CR>", { desc = "Go previous buffer" })

-- Indent keeping the visual mode
vim.keymap.set("v", "<tab>", ">gv", { desc = "Indent forward" })
vim.keymap.set("v", "<s-tab>", "<gv", { desc = "Indent backwar" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent forward" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent backward" })

-- Close buffer / tab
-- vim.keymap.set("n", "<C-w>", "<cmd>bd<CR>")
vim.keymap.set("n", "<C-w>", function()
	vim.cmd('NvimTreeClose')
	vim.cmd('bdelete')
end)
vim.keymap.set("n", "<leader>w", function()
	if not AskToSaveBeforeLeave() then
		return
	end

	vim.cmd('NvimTreeClose') -- Close the NvimTree
	vim.cmd('bdelete!')   -- Close the buffer
end, { desc = "Close buffer" })

-- Save file
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save buffer" })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>", { desc = "Save buffer" })
vim.keymap.set("n", "<Leader>s", "<cmd>w<CR>", { desc = "Save buffer" })

-- Quit
vim.keymap.set("n", "<leader>q", function()
	if not AskToSaveBeforeLeave() then
		return
	end

	vim.cmd("q!")
end, { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", function()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_get_option(buf, "modified") then
			local buf_name = vim.api.nvim_buf_get_name(buf)
			local choice = vim.fn.confirm("You have unsaved changes on " .. buf_name .. ". Save before closing?",
				"&Yes\n&No\n&Cancel", 1)
			if choice == 1 then
				vim.api.nvim_buf_call(buf, function() vim.cmd('write') end) -- Save buffer
			elseif choice == 2 then
			else
				return -- Cancel the operation
			end
		end
	end

	vim.cmd("qa!")
end, { desc = "Quit" })

-- Source file
-- vim.keymap.set("n", "<leader><leader>", "<cmd>so<CR>")

-- Add new empty lines
vim.keymap.set("n", "<S-CR>", "O<Esc>")
vim.keymap.set("n", "<CR>", "o<Esc>")

function AskToSaveBeforeLeave()
	if vim.bo.modified then
		-- Ask to save the file
		local choice = vim.fn.confirm("You have unsaved changes. Save before closing?", "&Yes\n&No\n&Cancel", 1)
		if choice == 1 then
			vim.cmd('write') -- Save the file
		elseif choice == 2 then
		else
			return false
		end
	end

	return true
end
