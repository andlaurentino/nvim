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

	return '🧪 ' .. table.concat(c, '|')
end

local my_colors = {
	dark_blue = '#1b4282',
	mid_blue  = '#008cc8',
	yellow    = '#ffbf01',

	new_blue  = '#1478b7',
	blue      = '#1478b7',
	-- blue      = '#1c7eff',
	orange    = '#f39b35',
	green     = '#35f394',
	violet    = '#5e60d8',
	cyan      = '#73daca',

	black     = '#080808',
	white     = '#ffffff',
	red       = '#ff5189',
	grey      = '#303030',
}

local colors = require("tokyonight.colors").setup()

local bubbles_theme = {
	normal = {
		a = { fg = my_colors.white, bg = my_colors.new_blue },
		b = { fg = colors.white, bg = colors.bg_highlight },
		c = { fg = colors.white, bg = "" },
		x = { fg = colors.white, bg = "" },
		y = { fg = colors.white, bg = "" },
		z = { fg = colors.white, bg = "" },
	},

	command = { a = { fg = colors.bg, bg = colors.orange }, x = { fg = colors.white, bg = "" }, y = { fg = colors.white, bg = "" }, z = { fg = colors.white, bg = "" }, },
	insert = { a = { fg = colors.bg, bg = colors.green }, x = { fg = colors.white, bg = "" }, y = { fg = colors.white, bg = "" }, z = { fg = colors.white, bg = "" }, },
	visual = { a = { fg = colors.bg, bg = colors.blue }, x = { fg = colors.white, bg = "" }, y = { fg = colors.white, bg = "" }, z = { fg = colors.white, bg = "" }, },
	replace = { a = { fg = colors.bg, bg = colors.cyan }, x = { fg = colors.white, bg = "" }, y = { fg = colors.white, bg = "" }, z = { fg = colors.white, bg = "" }, },

	inactive = {
		a = { fg = colors.white, bg = "" },
		b = { fg = colors.white, bg = "" },
		c = { fg = colors.white },
		x = { fg = colors.white, bg = "" },
		y = { fg = colors.white, bg = "" },
		z = { fg = colors.white, bg = "" },
	},
}

return {
	'nvim-lualine/lualine.nvim',
	dependencies = { "echasnovski/mini.icons" },
	opts = {
		options = {
			icons_enabled = true,
			theme = bubbles_theme,
			component_separators = '',
			section_separators = { left = '', right = '' },
			disabled_filetypes = {
				-- statusline = { "NvimTree" },
				-- winbar = { "NvimTree" },
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = true,
			refresh = {
				statusline = 100,
				tabline = 100,
				winbar = 100,
			}
		},
		sections = { -- 'diff', 'diagnostics'
			lualine_a = { { 'mode', separator = { left = '', right = '' } } },
			lualine_b = { { 'branch', icon = '', separator = { right = '' } } },
			lualine_c = { 'filename' },
			lualine_x = {
				clients_lsp,
				'encoding',
				{
					function()
						local expandtab = vim.api.nvim_buf_get_option(0, 'expandtab')
						local tabsize = vim.api.nvim_buf_get_option(0, 'shiftwidth')
						if expandtab then
							return 'spaces: ' .. tabsize
						else
							return 'tabs: ' .. tabsize
						end
					end,
					color = { fg = colors.white, bg = nil }, -- Customize the color as needed
				}, 'filetype'
			},
			lualine_y = { { 'progress' } },
			lualine_z = { { 'location', left_padding = 1 } }
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
