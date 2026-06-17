require("config")
require("shared.highlights") -- install ColorScheme/VimEnter autocmd before lazy setup

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Auto-discover all subdirectories under lua/modules/ and import each as a lazy module.
-- Adding a new domain = create a directory. Adding a plugin = drop a .lua file in it.
local function discover_modules()
	local modules_path = vim.fn.stdpath("config") .. "/lua/modules"
	local specs = {}
	for _, dir in ipairs(vim.fn.readdir(modules_path)) do
		if vim.fn.isdirectory(modules_path .. "/" .. dir) == 1 then
			table.insert(specs, { import = "modules." .. dir })
		end
	end
	return specs
end

require("lazy").setup(discover_modules())

-- Load persisted preferences (theme, indent, line numbers) from settings.json
require("config.settings").load()
