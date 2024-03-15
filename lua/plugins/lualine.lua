local clients_lsp = function()
	local bufnr = vim.api.nvim_get_current_buf()

	local clients = vim.lsp.buf_get_clients(bufnr)
	if next(clients) == nil then
		return ''
	end

	local c = {}
	for _, client in pairs(clients) do
		table.insert(c, client.name)
	end

	return '🔧 ' .. table.concat(c, '|')
end

local colors = {
	blue   = '#35c8f3',
	orange = '#f39b35',
	green  = '#35f394',
	violet = '#d183e8',

	cyan   = '#79dac8',
	black  = '#080808',
	white  = '#c6c6c6',
	red    = '#ff5189',
	grey   = '#303030',
}

local bubbles_theme = {
	normal = {
		a = { fg = colors.black, bg = colors.blue },
		b = { fg = colors.white, bg = "" },
		c = { fg = colors.white },
	},

	command = { a = { fg = colors.black, bg = colors.orange } },
	insert = { a = { fg = colors.black, bg = colors.violet } },
	visual = { a = { fg = colors.black, bg = colors.green } },
	replace = { a = { fg = colors.black, bg = colors.red } },

	inactive = {
		a = { fg = colors.white, bg = colors.black },
		b = { fg = colors.white, bg = colors.black },
		c = { fg = colors.white },
	},
}

return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {
		options = {
			icons_enabled = true,
			theme = bubbles_theme,
			component_separators = '',
			section_separators = { left = '', right = '' },
			disabled_filetypes = {
				-- statusline = { "NvimTree" },
				-- winbar = { "NvimTree" },
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			}
		},
		sections = {
			lualine_a = { 'mode' },
			lualine_b = { 'branch', 'diff', 'diagnostics' },
			lualine_c = { 'filename' },
			lualine_x = { clients_lsp, 'encoding', 'fileformat', 'filetype' },
			lualine_y = { 'progress' },
			lualine_z = { 'location' }
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { 'filename' },
			lualine_x = { 'location' },
			lualine_y = {},
			lualine_z = {}
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {}
	},
	config = function(_, opts)
		require("lualine").setup(opts)
		vim.cmd("set laststatus=3")
	end
}
