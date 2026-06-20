local function detect_python(root_dir)
	local candidates = {
		root_dir .. "/.venv/bin/python",
		root_dir .. "/venv/bin/python",
		root_dir .. "/env/bin/python",
	}
	for _, path in ipairs(candidates) do
		if vim.fn.executable(path) == 1 then return path end
	end

	if vim.fn.executable("poetry") == 1 and vim.fn.filereadable(root_dir .. "/pyproject.toml") == 1 then
		local out = vim.trim(vim.fn.system("poetry env info --path 2>/dev/null"))
		if vim.v.shell_error == 0 and out ~= "" then
			local path = out .. "/bin/python"
			if vim.fn.executable(path) == 1 then return path end
		end
	end

	if vim.fn.executable("uv") == 1 then
		local out = vim.trim(vim.fn.system("uv python find 2>/dev/null"))
		if vim.v.shell_error == 0 and out ~= "" then return out end
	end

	return vim.fn.exepath("python3") ~= "" and vim.fn.exepath("python3") or "python"
end

return {
	server = "pyright",
	setup = function(lsp)
		require('lspconfig').pyright.setup(lsp.build_options("pyright", {
			on_new_config = function(config, root_dir)
				config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
					python = { pythonPath = detect_python(root_dir) }
				})
			end,
		}))
	end
}
