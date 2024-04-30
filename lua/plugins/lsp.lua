return {
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		dependencies = {
			{ 'neovim/nvim-lspconfig' },
			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'L3MON4D3/LuaSnip' },
		},
		config = function()
			local lsp = require("lsp-zero")
			local cmp = require("cmp")
			local cmp_action = lsp.cmp_action()

			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					-- `Enter` key to confirm completion
					['<CR>'] = cmp.mapping.confirm({ select = false }),

					-- Ctrl+Space to trigger completion menu
					['<C-space>'] = cmp.mapping({
						i = function()
							if cmp.visible() then
								cmp.abort()
							else
								cmp.complete()
							end
						end,
						c = function()
							if cmp.visible() then
								cmp.close()
							else
								cmp.complete()
							end
						end,
					}),

					-- Navigate between snippet placeholder
					['<C-f>'] = cmp_action.luasnip_jump_forward(),
					['<C-b>'] = cmp_action.luasnip_jump_backward(),

					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),

					-- Scroll up and down in the completion documentation
					['<C-u>'] = cmp.mapping.scroll_docs(-4),
					['<C-d>'] = cmp.mapping.scroll_docs(4),
				})
			})

			lsp.on_attach(function(_, bufnr)
				lsp.default_keymaps({ buffer = bufnr })

				vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Go to definition" })
				vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, { desc = "Go to declaration" })
				vim.keymap.set("n", "<leader>ld", function() vim.lsp.buf.hover() end, { desc = "Show documentation" })
				vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, { desc = "Refactory Rename" })
				vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format { async = true } end,
					{ desc = "Format file" })
				vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end,
					{ desc = "Open Code Actions" })
				vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, { desc = "Go next diagnostics" })
				vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, { desc = "Go previous diagnostics" })
			end)

			lsp.setup()
			vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP Info" })
			vim.keymap.set("n", "<leader>lI", "<cmd>LspInstall<cr>", { desc = "Install new LSP" })
		end
	},
	{
		"williamboman/mason.nvim",
		opts = {}
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			local lsp = require("lsp-zero")
			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls",
					"pyright",
					"csharp_ls",
					"tsserver",
					"lua_ls",
					"tailwindcss"
				},
				handlers = {
					lsp.default_setup,
				},
			})
		end
	},
}
