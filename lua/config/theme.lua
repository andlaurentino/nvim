-- Force transparent backgrounds for BufferLine and Lualine after colorscheme changes
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
	callback = function()
		vim.schedule(function()
			local hl_groups = {
				"StatusLine",
				"StatusLineNC",
				"lualine_c_normal",
				"lualine_c_insert",
				"lualine_c_visual",
				"lualine_c_replace",
				"lualine_c_command",
				"lualine_c_inactive",
				"TabLineFill",
				"BufferLineFill",
				"BufferLineBackground",
			}
			for _, name in ipairs(hl_groups) do
				pcall(vim.cmd, string.format("hi %s guibg=NONE ctermbg=NONE", name))
			end
		end)
	end,
})
