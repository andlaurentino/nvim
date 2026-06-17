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

-- █          

return {
	'nvim-lualine/lualine.nvim',
	dependencies = { "echasnovski/mini.icons" },
	opts = {
		options = {
			icons_enabled = true,
			theme = "auto",
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
			lualine_a = { { icon = "", "mode", separator = { left = '', right = '' } } },
			lualine_b = { { 'branch', icon = '󰊢', separator = { right = '' } } },
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
					-- Customize the color as needed, e.g., color = { bg = nil }
				}, 'filetype'
			},
			lualine_y = { { 'progress', separator = { left = '' } } },
			lualine_z = { { 'location', left_padding = 1, separator = { left = '', right = '' } } }
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

		local hl = require("shared.highlights")
		hl.register_transparent({
			"StatusLine",
			"StatusLineNC",
			"TabLineFill",
			"TabLine",
			"lualine_c_normal",
			"lualine_c_insert",
			"lualine_c_visual",
			"lualine_c_replace",
			"lualine_c_command",
			"lualine_c_inactive",
		})
		hl.apply_transparent()
	end
}
