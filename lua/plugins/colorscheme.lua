return {
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
			style = "storm",
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
		config = function(_, opts)
			local theme = require "tokyonight"
			theme.setup(opts)
			theme.load()
		end,
	},
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	opts = {
	-- 		flovour = "mocha",
	-- 		transparent_background = true,
	-- 	},
	-- 	config = function(_, opts)
	-- 		local theme = require "catppuccin"
	-- 		theme.setup(opts)
	-- 	end,
	-- },
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	priority = 1000,
	-- 	opts = {
	-- 		styles = {
	-- 			transparency = true,
	-- 		},
	-- 	},
	-- 	config = function(_, opts)
	-- 		local theme = require "rose-pine"
	-- 		theme.setup(opts)
	-- 	end,
	-- },
	-- {
	-- 	"Mofiqul/vscode.nvim",
	-- 	name = "vscode",
	-- 	priority = 1000,
	-- 	opts = {
	-- 		transparent = true,
	-- 		disable_nvimtree_bg = true,
	-- 	},
	-- 	config = function(_, opts)
	-- 		local theme = require "vscode"
	-- 		theme.setup(opts)
	-- 	end,
	-- }
}
