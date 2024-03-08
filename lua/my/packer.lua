local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}

	use {
		"folke/tokyonight.nvim",
		as = "tokyonight",
	}

	use {
		"nvim-treesitter/nvim-treesitter",
		{ run = ":TSUpdate" }
	}

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		requires = {
			{ 'neovim/nvim-lspconfig' },
			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'L3MON4D3/LuaSnip' },
		}
	}

	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	}

	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons',
		},
	}

	use {
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup {}
		end
	}

	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}

	use {
		'akinsho/bufferline.nvim',
		tag = "*",
		requires = 'nvim-tree/nvim-web-devicons'
	}

	use {
		"akinsho/toggleterm.nvim",
		tag = '*',
		config = function()
			require("toggleterm").setup()
		end
	}

	use "echasnovski/mini.nvim"
	use "lukas-reineke/indent-blankline.nvim"

	use "lewis6991/gitsigns.nvim"

	use "mg979/vim-visual-multi"

	use "stevearc/dressing.nvim"

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
