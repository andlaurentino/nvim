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
	}
}
