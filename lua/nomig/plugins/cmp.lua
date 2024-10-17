return {
	"saghen/blink.cmp",
	lazy = false,
	dependencies = "rafamadriz/friendly-snippets",

	opts = {
		nerd_font_variant = "normal",
		trigger = { signature_help = { enabled = true } },
		keymap = {
			accept = "<C-y>",
			select_next = "<C-n>",
			select_prev = "<C-p>",
			snippet_forward = "<Tab>",
			snippet_backward = "<S-Tab>",
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
		fuzzy = {
			prebuiltBinaries = {
				-- forceVersion = "0.1.0",
			},
		},
	},
}
