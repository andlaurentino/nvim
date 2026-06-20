local M = {}

function M.on(events, fn, opts)
	vim.api.nvim_create_autocmd(events, vim.tbl_extend("force", { callback = fn }, opts or {}))
end

function M.on_buf(bufnr, events, fn)
	vim.api.nvim_create_autocmd(events, { buffer = bufnr, callback = fn })
end

return M
