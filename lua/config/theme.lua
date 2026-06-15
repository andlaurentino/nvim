local M = {}
local settings_dir = vim.fn.stdpath("config") .. "/settings"
local theme_file = settings_dir .. "/theme.json"

function M.save_theme(theme)
	if vim.fn.isdirectory(settings_dir) == 0 then
		vim.fn.mkdir(settings_dir, "p")
	end
	local f = io.open(theme_file, "w")
	if f then
		f:write(vim.fn.json_encode({ theme = theme }))
		f:close()
	end
end

function M.load_theme(default)
	local f = io.open(theme_file, "r")
	local theme = default
	if f then
		local saved_data = f:read("*a")
		f:close()
		local ok, decoded = pcall(vim.fn.json_decode, saved_data)
		if ok and type(decoded) == "table" and decoded.theme then
			theme = decoded.theme
		end
	end

	-- Try to load the saved theme, fallback to default if it fails
	local ok, _ = pcall(vim.cmd.colorscheme, theme)
	if not ok then
		vim.cmd.colorscheme(default)
	end
end

-- Automatically save the theme whenever it changes (e.g., via Telescope)
-- Also re-apply transparent backgrounds on VimEnter to ensure Lualine doesn't overwrite it on startup
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
	callback = function(args)
		if args.event == "ColorScheme" and args.match then
			M.save_theme(args.match)
		end

		-- Force transparent backgrounds for BufferLine and Lualine
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

return M
