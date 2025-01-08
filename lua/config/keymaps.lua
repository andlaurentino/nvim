vim.g.mapleader = " "

-- Prevent clear the clipboard after Past
vim.cmd("xnoremap <expr> p 'pgv\"'.v:register.'y`>'")
vim.cmd("xnoremap <noremap <expr> P 'Pgv\"'.v:register.'y`>'")

-- Spliting
vim.keymap.set("n", "|", vim.cmd.vsplit, { desc = "Vertical split" })
vim.keymap.set("n", "-", vim.cmd.split, { desc = "Horizontal split" })

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
end, { desc = "Quit all" })

-- Source file
-- vim.keymap.set("n", "<leader><leader>", "<cmd>so<CR>")

-- Add new empty lines
-- vim.keymap.set("n", "<S-CR>", "O<Esc>")
-- vim.keymap.set("n", "<CR>", "o<Esc>")

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

vim.keymap.set("n", "<leader>n", "<cmd>enew<CR>", { desc = "New buffer" })
vim.keymap.set("n", "<leader>bt", function()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local conf = require("telescope.config").values

	-- List of all available filetypes in Neovim
	local filetypes = vim.fn.getcompletion('', 'filetype')

	-- Get the current buffer number
	local bufnr = vim.api.nvim_get_current_buf()

	-- Define the picker
	pickers.new({}, {
		prompt_title = "Select or Enter Filetype",
		finder = finders.new_table({
			results = filetypes
		}),
		sorter = conf.generic_sorter({}),
		attach_mappings = function(_, map)
			-- Define action on selection
			map('i', '<CR>', function(prompt_bufnr)
				local selected = action_state.get_selected_entry()


				if selected then
					-- Set the filetype of the current buffer to the selected one using Lua API
					vim.api.nvim_buf_set_option(bufnr, "filetype", selected[1])
				else
					-- If no selection is made (user inputted a new value), get the prompt value
					local new_value = action_state.get_current_line()
					if new_value ~= "" then
						vim.api.nvim_buf_set_option(bufnr, "filetype", new_value)
					end
				end
				actions.close(prompt_bufnr)
			end)

			-- Bind <C-e> to manually input a new filetype
			map('i', '<C-e>', function(prompt_bufnr)
				local new_value = action_state.get_current_line()
				if new_value ~= "" then
					vim.api.nvim_buf_set_option(bufnr, "filetype", new_value)
				end
				actions.close(prompt_bufnr)
			end)

			return true
		end,
	}):find()
end, { desc = "Change Filetype" })

local function set_spacing(expandtab, tabstop, shiftwidth, softtabstop)
	vim.api.nvim_buf_set_option(0, 'expandtab', expandtab)
	vim.api.nvim_buf_set_option(0, 'tabstop', tabstop)
	vim.api.nvim_buf_set_option(0, 'shiftwidth', shiftwidth)
	vim.api.nvim_buf_set_option(0, 'softtabstop', softtabstop)
end

vim.keymap.set("n", "<leader>bs", function()
	local pickers = require('telescope.pickers')
	local finders = require('telescope.finders')
	local actions = require('telescope.actions')
	local action_state = require('telescope.actions.state')

	local options = {
		{ expandtab = true,  tabstop = 2, shiftwidth = 2, softtabstop = 2, description = "Spaces: 2" },
		{ expandtab = true,  tabstop = 4, shiftwidth = 4, softtabstop = 4, description = "Spaces: 4" },
		{ expandtab = false, tabstop = 2, shiftwidth = 2, softtabstop = 2, description = "Tabs: 2" },
		{ expandtab = false, tabstop = 4, shiftwidth = 4, softtabstop = 4, description = "Tabs: 4" },
	}

	pickers.new({}, {
		prompt_title = "Toggle Spacing",
		finder = finders.new_table {
			results = options,
			entry_maker = function(entry)
				return {
					value = entry,
					display = entry.description,
					ordinal = entry.description,
				}
			end,
		},
		sorter = require('telescope.config').values.generic_sorter({}),
		attach_mappings = function(_, map)
			actions.select_default:replace(function()
				actions.close(_)
				local selection = action_state.get_selected_entry().value
				set_spacing(
					selection.expandtab,
					selection.tabstop,
					selection.shiftwidth,
					selection.softtabstop
				)
			end)
			return true
		end,
	}):find()
end, { desc = "Toggle Spacing" })

vim.keymap.set('n', '<leader>bn', function()
    if vim.wo.relativenumber then
        vim.wo.number = true
        vim.wo.relativenumber = false
    else
        vim.wo.number = true
        vim.wo.relativenumber = true
    end
end, { desc = 'Toggle relative numbers' })

