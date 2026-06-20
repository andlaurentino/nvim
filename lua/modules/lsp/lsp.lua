return {
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		dependencies = {
			{ 'neovim/nvim-lspconfig' },
			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'L3MON4D3/LuaSnip' },
			{ 'rafamadriz/friendly-snippets' },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'vim-dadbod-completion' },
		},
		keys = {
			{
				"<leader>lm",
				"<cmd>Mason<cr>",
				desc = "Mason",
			},
		},
		config = function()
			local lsp = require("lsp-zero")
			local cmp = require("cmp")
			local cmp_action = lsp.cmp_action()
			local luasnip = require('luasnip')
			local keys = require("shared.keys")
			local hl = require("shared.highlights")

			cmp.setup.filetype({ "sql" }, {
				sources = {
					{ name = "vim-dadbod-completion" },
					{ name = "buffer" },
				},
			})

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
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
					['<TAB>'] = cmp_action.luasnip_jump_forward(),
					['<C-b>'] = cmp_action.luasnip_jump_backward(),
					['<S-TAB>'] = cmp_action.luasnip_jump_backward(),

					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),

					-- Scroll up and down in the completion documentation
					['<C-u>'] = cmp.mapping.scroll_docs(-4),
					['<C-d>'] = cmp.mapping.scroll_docs(4),
				}),
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
					{ name = 'buffer' },
					{ name = 'path' },
				},
				window = {
					completion = {
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- Rounded borders
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
					},
					documentation = {
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- Rounded borders for docs
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
					},
				},
			})

			local colors = require("tokyonight.colors").setup()
			hl.set("Pmenu", { bg = colors.bg_float, fg = colors.fg })
			hl.set("PmenuSel", { bg = colors.green, fg = colors.bg })
			hl.set("FloatBorder", { bg = colors.none, fg = colors.blue })

			lsp.on_attach(function(_, bufnr)
				lsp.default_keymaps({ buffer = bufnr })

				keys.buf_map(bufnr, "n", "gd", function() vim.lsp.buf.definition() end, "Go to definition")
				keys.buf_map(bufnr, "n", "gD", function() vim.lsp.buf.declaration() end, "Go to declaration")
				keys.buf_map(bufnr, "n", "<leader>ld", function() vim.lsp.buf.hover() end, "Show documentation")
				keys.buf_map(bufnr, "n", "<leader>lr", function() vim.lsp.buf.rename() end, "Refactory Rename")
				keys.buf_map(bufnr, "n", "<leader>lf", function() vim.lsp.buf.format { async = true } end, "Format file")
				keys.buf_map(bufnr, "n", "<leader>la", function() vim.lsp.buf.code_action() end, "Open Code Actions")
				keys.buf_map(bufnr, "n", "[d", function() vim.diagnostic.goto_next() end, "Go next diagnostics")
				keys.buf_map(bufnr, "n", "]d", function() vim.diagnostic.goto_prev() end, "Go previous diagnostics")

				vim.lsp.handlers["window/showMessage"] = function() end
				vim.lsp.handlers["window/logMessage"] = function() end
			end)

			lsp.setup()
			vim.lsp.set_log_level("WARN")
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

			local function load_lang_handlers()
				local langs_dir = vim.fn.stdpath("config") .. "/lua/modules/lsp/langs"
				local handlers = {}
				if vim.fn.isdirectory(langs_dir) == 1 then
					for _, file in ipairs(vim.fn.readdir(langs_dir)) do
						if file:match("%.lua$") then
							local mod = file:gsub("%.lua$", "")
							local ok, lang = pcall(require, "modules.lsp.langs." .. mod)
							if ok and lang.server and lang.setup then
								handlers[lang.server] = function() lang.setup(lsp) end
							end
						end
					end
				end
				return handlers
			end

			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls",
					"pyright",
					-- "csharp_ls",
					-- "omnisharp",
					-- "tsserver",
					"lua_ls",
					"tailwindcss",
					"terraformls"
				},
				handlers = vim.tbl_extend("force", { lsp.default_setup }, load_lang_handlers()),
			})
		end
	},
}
