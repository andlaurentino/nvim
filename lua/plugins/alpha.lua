return {
	'goolord/alpha-nvim',
	priority = 1000,
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		local alpha = require('alpha')
		local dashboard = require('alpha.themes.dashboard')

		-- Set header
		dashboard.section.header.val = {
			[[   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ]],
			[[    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ]],
			[[          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ]],
			[[           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ]],
			[[          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ]],
			[[   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ]],
			[[  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ]],
			[[ ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ]],
			[[ ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ]],
			[[      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ]],
			[[       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ]],
		}

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("<space>e", "  Open File Explorer", ":Neotree<CR>"),
			dashboard.button("<space>ff", "  Find file", ":Telescope find_files<CR>"),
			dashboard.button("<space>D", "  DBUI", ":DBUIToggle<CR>"),
			dashboard.button("q", "  Quit", ":qa<CR>"),
		}

		-- Set footer
		local function footer()
			local stats = require("lazy").stats()
			local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
			return "⚡ neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
		end

		dashboard.section.footer.val = footer()

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer and auto close it
		vim.cmd([[
            autocmd FileType alpha setlocal nofoldenable
            autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
            autocmd User AlphaReady set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
        ]])

		-- Automatically open dashboard when no arguments were passed
		-- vim.api.nvim_create_autocmd("VimEnter", {
		-- 	callback = function()
		-- 		require("alpha").start()
		-- 	end,
		-- })

		-- Automatically open dashboard when no arguments were passed
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				require("alpha").start()
			end,
		})
	end
};
