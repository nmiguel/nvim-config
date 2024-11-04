return {
	"saghen/blink.cmp",
	lazy = false,
	dependencies = "rafamadriz/friendly-snippets",
    version = 'v0.*',

	opts = {
		nerd_font_variant = "normal",
		trigger = { signature_help = { enabled = true } },
		keymap = {
			preset = "default",
		},
		accept = {
			create_undo_point = false,
		},
		windows = {
			autocomplete = {
				border = "single",
			},
			documentation = {
				border = "single",
			},
			signature_help = {
				border = "single",
			},
		},
	},
}
