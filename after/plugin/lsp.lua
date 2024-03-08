local status_ok, lsp = pcall(require, "lsp-zero")
if not status_ok then return end

local status_ok, cmp = pcall(require, "cmp")
if not status_ok then return end

local cmp_action = lsp.cmp_action()

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		-- `Enter` key to confirm completion
		['<CR>'] = cmp.mapping.confirm({ select = false }),

		-- Ctrl+Space to trigger completion menu
		['<C-Space>'] = cmp.mapping.complete(),

		-- Navigate between snippet placeholder
		['<C-f>'] = cmp_action.luasnip_jump_forward(),
		['<C-b>'] = cmp_action.luasnip_jump_backward(),

		-- Scroll up and down in the completion documentation
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
	})
})

lsp.on_attach(function(_, bufnr)
	lsp.default_keymaps({ buffer = bufnr })

	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
	vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end)
	vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>")
	vim.keymap.set("n", "<leader>lI", "<cmd>LspInstall<cr>")
	vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end)
	vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format { async = true } end)
	vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end)
end)

lsp.setup()

local status_ok, mason = pcall(require, "mason")
if not status_ok then return end

mason.setup({})

local status_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not status_ok then return end

mason_lsp.setup({
	ensure_installed = {
		"gopls",
		"pyright",
		"csharp_ls",
		"tsserver",
	},
	handlers = {
		lsp.default_setup,
	},
})
