local M = {}

local SUPPORTED_KEYS = {
	"theme",
	"expandtab",
	"tabstop",
	"shiftwidth",
	"softtabstop",
	"number",
	"relativenumber",
}

local config_dir = vim.fn.stdpath("config")
local global_file = config_dir .. "/settings.json"
local project_file = vim.fn.getcwd() .. "/.nvim/settings.json"
local legacy_theme_file = config_dir .. "/settings/theme.json"

local active_file = nil
local saving = false

local function file_exists(path)
	return vim.fn.filereadable(path) == 1
end

local function read_json(path)
	local f = io.open(path, "r")
	if not f then
		return nil
	end
	local contents = f:read("*a")
	f:close()
	local ok, decoded = pcall(vim.fn.json_decode, contents)
	if ok and type(decoded) == "table" then
		return decoded
	end
	return nil
end

local function encode_value(v)
	if type(v) == "boolean" or type(v) == "number" then
		return tostring(v)
	end
	return vim.fn.json_encode(v)
end

local function encode_pretty(tbl)
	local lines = { "{" }
	local entries = {}
	for _, key in ipairs(SUPPORTED_KEYS) do
		if tbl[key] ~= nil then
			table.insert(entries, string.format('  %s: %s', vim.fn.json_encode(key), encode_value(tbl[key])))
		end
	end
	table.insert(lines, table.concat(entries, ",\n"))
	table.insert(lines, "}\n")
	return table.concat(lines, "\n")
end

local function write_json(path, tbl)
	local dir = vim.fn.fnamemodify(path, ":h")
	if vim.fn.isdirectory(dir) == 0 then
		vim.fn.mkdir(dir, "p")
	end
	local f = io.open(path, "w")
	if not f then
		return
	end
	f:write(encode_pretty(tbl))
	f:close()
end

local function resolve_active_file()
	if file_exists(project_file) then
		return project_file
	end
	return global_file
end

local function apply(settings)
	if settings.theme then
		local ok = pcall(vim.cmd.colorscheme, settings.theme)
		if not ok then
			pcall(vim.cmd.colorscheme, "tokyonight")
		end
	end
	if settings.expandtab ~= nil then
		vim.opt.expandtab = settings.expandtab
	end
	if settings.tabstop ~= nil then
		vim.opt.tabstop = settings.tabstop
	end
	if settings.shiftwidth ~= nil then
		vim.opt.shiftwidth = settings.shiftwidth
	end
	if settings.softtabstop ~= nil then
		vim.opt.softtabstop = settings.softtabstop
	end
	if settings.number ~= nil then
		vim.opt.number = settings.number
	end
	if settings.relativenumber ~= nil then
		vim.opt.relativenumber = settings.relativenumber
	end
end

local function current_values()
	return {
		theme = vim.g.colors_name,
		expandtab = vim.opt.expandtab:get(),
		tabstop = vim.opt.tabstop:get(),
		shiftwidth = vim.opt.shiftwidth:get(),
		softtabstop = vim.opt.softtabstop:get(),
		number = vim.opt.number:get(),
		relativenumber = vim.opt.relativenumber:get(),
	}
end

function M.active_path()
	return active_file
end

function M.save()
	if saving or not active_file then
		return
	end
	saving = true
	write_json(active_file, current_values())
	saving = false
end

function M.load()
	active_file = resolve_active_file()

	local settings = read_json(active_file)

	if not settings and active_file == global_file and file_exists(legacy_theme_file) then
		local legacy = read_json(legacy_theme_file)
		if legacy and legacy.theme then
			settings = { theme = legacy.theme }
			write_json(global_file, settings)
		end
	end

	if settings then
		apply(settings)
	end
end

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		if active_file then
			M.save()
		end
	end,
})

return M
