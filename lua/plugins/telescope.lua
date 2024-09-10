return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.5',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		require('telescope').setup {
			defaults = {
				layout_strategy = 'vertical',
				layout_config = {
					vertical = {
						width = 0.8,
						prompt_position = "top",
						mirror = true,
						preview_cutoff = 0,
					}
				},
				mappings = {
					i = {
						["<C-j>"] = require('telescope.actions').move_selection_next,
						["<C-k>"] = require('telescope.actions').move_selection_previous,
					}
				},
				file_ignore_patterns = {
					"node_modules"
				}
			}
		}
		local builtin = require("telescope.builtin")

		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
		vim.keymap.set('n', '<leader>p', builtin.find_files, { desc = "Find files" })
		vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "Find git files" })
		vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find opened buffers" })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Find helper" })
		vim.keymap.set('n', '<leader>ht', "<cmd>Telescope colorscheme<CR>", { desc = "Change color scheme" })
	end
}
