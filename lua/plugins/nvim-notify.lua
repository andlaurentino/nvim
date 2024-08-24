return {
	"rcarriga/nvim-notify",
	opts = {
		stages = "fade_in_slide_out",
		timeout = 2000,
		minimum_width = 50,
		icons = {
			ERROR = "",
			WARN = "",
			INFO = "",
			DEBUG = "",
			TRACE = "✎",
		},
		-- render = "minimal",
		max_width = 80,
		max_height = 12,
		top_down = false,
	}
}
