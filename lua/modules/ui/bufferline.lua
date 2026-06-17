return {
	'akinsho/bufferline.nvim',
	version = "*",
	dependencies = { 'echasnovski/mini.icons' },
	opts = {
		options = {
			indicator = {
				style = 'underline',
			},
			offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
		}
	},
	config = function(_, opts)
		require("bufferline").setup(opts)

		local hl = require("shared.highlights")
		hl.register_transparent({
			"BufferLineFill",
			"BufferLineBackground",
			"BufferLineCurrent",
			"BufferLineCurrentModified",
			"BufferLineCurrentSign",
			"BufferLineVisible",
			"BufferLineVisibleModified",
			"BufferLineVisibleSign",
			"BufferLineTab",
			"BufferLineTabSelected",
			"BufferLineTabClose",
			"BufferLineCloseButton",
			"BufferLineCloseButtonVisible",
			"BufferLineCloseButtonSelected",
			"BufferLineBuffer",
			"BufferLineBufferVisible",
			"BufferLineBufferSelected",
			"BufferLineSeparator",
			"BufferLineSeparatorVisible",
			"BufferLineSeparatorSelected",
		})
		hl.apply_transparent()
	end
}
