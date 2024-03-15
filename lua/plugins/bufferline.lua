return {
	'akinsho/bufferline.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {
		options = {
			indicator = {
                -- icon = '▎', -- this should be omitted if indicator style is not 'icon'
                -- icon = '', -- this should be omitted if indicator style is not 'icon'
				-- style = 'underline',
				-- underline_thickness = "10px"
			},
			offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
		}
	}
}
