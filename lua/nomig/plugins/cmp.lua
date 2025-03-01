return {
	"saghen/blink.cmp",
	lazy = false,
	-- enabled = false,
	dependencies = { { "L3MON4D3/LuaSnip", version = "v2.*" }, "xzbdmw/colorful-menu.nvim" },
	version = "v0.13.x",

	config = function()
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
					draw = {
						-- We don't need label_description now because label and label_description are already
						-- conbined together in label by colorful-menu.nvim.
						columns = { { "kind_icon" }, { "label", gap = 1 } },
						components = {
							label = {
								text = require("colorful-menu").blink_components_text,
								highlight = require("colorful-menu").blink_components_highlight,
							},
						},
					},
				},

				documentation = {
					auto_show = true,
					auto_show_delay_ms = 100,
					window = {
						border = rounded_border,
					},
				},
			},
			signature = {
				enabled = true,
				window = {
					border = rounded_border,
				},
			},
			cmdline = {enabled = false},
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
			snippets = {
				preset = "luasnip",
			},
		})
	end,
}
