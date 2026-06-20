return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local keys = require("shared.keys")
		local autocmds = require("shared.autocmds")

		require('gitsigns').setup {
			signs = {
				add          = { text = '│' },
				change       = { text = '│' },
				delete       = { text = '_' },
				topdelete    = { text = '‾' },
				changedelete = { text = '~' },
				untracked    = { text = '│' },
			},
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				follow_files = true
			},
			auto_attach = true,
			attach_to_untracked = true,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
				delay = 100,
				ignore_whitespace = false,
				virt_text_priority = 100,
			},
			current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
			sign_priority = 6,
			update_debounce = 10,
			status_formatter = nil, -- Use default
			max_file_length = 40000, -- Disable if file is longer than this (in lines)
			preview_config = {
				-- Options passed to nvim_open_win
				border = 'single',
				style = 'minimal',
				relative = 'cursor',
				row = 0,
				col = 1
			},
			on_attach = function(bufnr)
				local gitsigns = require('gitsigns')

				-- Navigation
				keys.buf_map(bufnr, 'n', ']c', function()
					if vim.wo.diff then
						vim.cmd.normal({ ']c', bang = true })
					else
						gitsigns.nav_hunk('next')
					end
				end, "Next hunk")

				keys.buf_map(bufnr, 'n', '[c', function()
					if vim.wo.diff then
						vim.cmd.normal({ '[c', bang = true })
					else
						gitsigns.nav_hunk('prev')
					end
				end, "Previous hunk")

				autocmds.on_buf(bufnr, 'CursorHold', function()
					gitsigns.toggle_current_line_blame()
				end)

				-- Actions
				keys.buf_map(bufnr, 'n', '<leader>gb', function() gitsigns.blame_line {} end, "Git blame")
				keys.buf_map(bufnr, 'n', '<leader>gf', function() gitsigns.blame_line { full = true } end, "Git blame full")
				keys.buf_map(bufnr, 'n', '<leader>gt', gitsigns.toggle_current_line_blame, "Git blame line")
				keys.buf_map(bufnr, 'n', '<leader>gd', gitsigns.diffthis, "Git diff this")
				keys.buf_map(bufnr, 'n', '<leader>gx', gitsigns.toggle_deleted, "Toggle delete")

				-- Text object
				vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { buffer = bufnr })
			end
		}
	end
}
