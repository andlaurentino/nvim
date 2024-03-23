return {
	"echasnovski/mini.nvim",
	config = function()
		-- local pairs = require("mini.pairs")
		local move = require("mini.move")
		local surround = require("mini.surround")
		-- local trailspace = require("mini.trailspace")
		local indentscope = require("mini.indentscope")
		local comment = require("mini.comment")

		-- pairs.setup()
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
		comment.setup()
	end
}
