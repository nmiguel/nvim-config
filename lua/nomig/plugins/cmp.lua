return {
	"saghen/blink.cmp",
	lazy = false,
	dependencies = "rafamadriz/friendly-snippets",
	version = "v0.*",

	config = function()
		---@diagnostic disable: missing-fields
        local rounded_border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
		require("blink.cmp").setup({
			appearance = {
				nerd_font_variant = "normal",
			},

			keymap = {
				preset = "default",
			},

			completion = {
				accept = {
					create_undo_point = false,
					auto_brackets = {
						enabled = false,
					},
				},

				menu = {
					border = rounded_border,
				},

				documentation = {
					auto_show = true,
					window = {
						border = rounded_border,
					},
				},

				signature = {
					enabled = true,
					window = {
						border = rounded_border,
					},
				},
			},
		})
	end,
}
