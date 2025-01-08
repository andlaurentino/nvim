return {
	{
		"echasnovski/mini.icons",
		opts = {},
		lazy = true,
		specs = {
			{ "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	{
		"echasnovski/mini.nvim",
		config = function()
			local pairs = require("mini.pairs")
			local move = require("mini.move")
			local surround = require("mini.surround")
			-- local trailspace = require("mini.trailspace")
			local indentscope = require("mini.indentscope")

			-- TODO: Change the comment library
			local comment = require("mini.comment")

			pairs.setup()
			move.setup({
				mappings = {
					-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
					-- left = '<M-h>',
					-- right = '<M-l>',
					left = '˙',
					right = '¬',
					down = '∆',
					up = '˚',

					-- Move current line in Normal mode
					-- line_left = '<M-h>',
					-- line_right = '<M-l>',
					line_left = '˙',
					line_right = '¬',
					line_down = '∆',
					line_up = '˚',
				},

				-- Options which control moving behavior
				options = {
					-- Automatically reindent selection during linewise vertical move
					reindent_linewise = true,
				},
			})
			surround.setup()
			-- trailspace.setup({
			-- 	only_in_normal_buffers = true,
			-- })
			indentscope.setup({
				symbol = "│",
				options = { try_as_border = true },
			})
			-- comment.setup()
		end
	}
}
