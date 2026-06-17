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
			local trailspace = require("mini.trailspace")
			local indentscope = require("mini.indentscope")

			pairs.setup()
			move.setup({
				mappings = {
					-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
					left = '˙',
					right = '¬',
					down = '∆',
					up = '˚',

					-- Move current line in Normal mode
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
			indentscope.setup({
				symbol = "│",
				options = { try_as_border = true },
			})
		end
	}
}
