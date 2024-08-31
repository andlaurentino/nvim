return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = { "rust", "python", "go", "c", "c_sharp", "lua", "vim", "vimdoc", "query", "css", "javascript", "typescript", "svelte"  },

		-- sync_install = false,
		-- auto_install = true,
		highlight = {
			enable = true,
			-- additional_vim_regex_highlighting = false,
		},
	},
	config = function (_, values)
		require("nvim-treesitter.configs").setup(values)
	end
}
