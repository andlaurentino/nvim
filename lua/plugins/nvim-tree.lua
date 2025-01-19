local function my_on_attach(bufnr)
	local api = require "nvim-tree.api"

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Open")
	vim.keymap.set("n", "l", api.node.open.edit, opts "Close Directory")
end

return {
	'nvim-tree/nvim-tree.lua',
	-- dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {
		on_attach = my_on_attach,
		sync_root_with_cwd = true,
		hijack_unnamed_buffer_when_opening = true,
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
		sort = {
			sorter = "case_sensitive",
		},
		view = {
			side = 'right',
			width = 30,
		},
		renderer = {
			group_empty = false,
			root_folder_modifier = ":t",
			indent_markers = {
				enable = true,
				icons = {
					corner = "└",
					edge = "│",
					item = "│",
					none = " "
				}
			},
			icons = {
				glyphs = {
					default = "",
					symlink = "",
					folder = {
						arrow_open = "",
						arrow_closed = "",
						default = "",
						open = "",
						empty = "",
						empty_open = "",
						symlink = "",
						symlink_open = "",
					},
					git = {
						unstaged = "",
						staged = "S",
						unmerged = "",
						renamed = "➜",
						untracked = "U",
						deleted = "",
						ignored = "◌",
					},
				},
			},
		},
		diagnostics = {
			enable = true,
			show_on_dirs = true,
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},
		filters = {
			dotfiles = false,
			git_clean = false,
			git_ignored = true,
			custom = { "^.git$", "^node_modules$" }
		},
	},
	config = function(_, opts)
		require("nvim-tree").setup(opts)
		-- Open NvimTree
		vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Open Navigation Tree" })
	end
}
