return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	version = false,
	opts = {
		provider = "claude",
		claude = {
			model = "claude-3-5-sonnet-20241022"
		}
	},
	config = function(_, opts)
		require('avante_lib').load()
		require("avante").setup(opts)
	end,
	build = "make BUILD_FROM_SOURCE=true",
	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"hrsh7th/nvim-cmp",
		-- "nvim-tree/nvim-web-devicons",
		"echasnovski/mini.icons",
	},
}
