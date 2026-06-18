return {
	"saghen/blink.cmp",
	-- lazy = false,
	-- enabled = false,
	dependencies = {
		"saghen/blink.lib",
		"rafamadriz/friendly-snippets",
		"xzbdmw/colorful-menu.nvim", -- Treesitter support in cmp menu
	},
	build = function()
		-- build the fuzzy matcher, optionally add a timeout to `pwait(timeout_ms)`
		-- you can use `gb` in `:Lazy` to rebuild the plugin as needed
		require("blink.cmp").build():pwait()
	end,
	-- version = "v2.*",

	config = function()
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
					draw = {
						columns = { { "kind_icon" }, { "label" } },
						components = {
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
					},
				},

				documentation = {
					auto_show = true,
					-- auto_show_delay_ms = 100,
				},
			},
			signature = {
				enabled = true,
			},
			cmdline = { enabled = false },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		})
	end,
}
