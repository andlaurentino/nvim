return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"echasnovski/mini.icons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			-- close_if_last_window = true,
			auto_open = false,
			popup_border_style = "rounded",
			window = {
				position = "right",
				width = 30,
				mappings = {
					["l"] = "open",
					["h"] = "close_node",
				}
			},
			filesystem = {
				hijack_netrw_behavior = "disabled",
				follow_current_file = false,
				filtered_items = {
					visible = false,
					hide_dotfiles = true,
					hide_gitignored = true,
				},
			},
		})

		vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', {
			silent = true,
			desc = "Toggle Neo-tree"
		})
	end,
}
