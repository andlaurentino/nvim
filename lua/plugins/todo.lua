return {
	"folke/todo-comments.nvim",
	lazy = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
	keys = {
		{
			"<leader>ft",
			"<cmd>TodoTelescope<cr>",
			desc = "Todo`s list",
		},
	}
}
