local M = {}
local _transparent_groups = {}

local function apply()
	for _, name in ipairs(_transparent_groups) do
		pcall(vim.cmd, string.format("hi %s guibg=NONE ctermbg=NONE guifg=NONE ctermfg=NONE blend=100", name))
	end
end

vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
	callback = function()
		vim.schedule(apply)
	end,
})

function M.register_transparent(groups)
	for _, g in ipairs(groups) do
		table.insert(_transparent_groups, g)
	end
end

function M.apply_transparent()
	apply()
end

function M.set(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
end

return M
