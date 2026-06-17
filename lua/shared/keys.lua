local M = {}

function M.map(mode, lhs, rhs, desc, extra_opts)
	local opts = vim.tbl_extend("force", { desc = desc, silent = true }, extra_opts or {})
	vim.keymap.set(mode, lhs, rhs, opts)
end

function M.buf_map(bufnr, mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { desc = desc, buffer = bufnr, silent = true })
end

return M
