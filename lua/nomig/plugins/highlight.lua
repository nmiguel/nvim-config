return {
	"brenoprata10/nvim-highlight-colors",
	event = "BufEnter",

	dependencies = {
		{
			"RRethy/vim-illuminate",
			config = function()
				require("illuminate").configure({
					providers = {
						"lsp",
						"treesitter",
						"regex",
					},
					-- delay: delay in milliseconds
					delay = 100,
					-- filetype_overrides: filetype specific overrides.
					-- The keys are strings to represent the filetype while the values are tables that
					-- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
					filetype_overrides = {},
					-- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
					filetypes_denylist = {
						"dirbuf",
						"dirvish",
						"fugitive",
					},
					-- under_cursor: whether or not to illuminate under the cursor
					under_cursor = true,
					min_count_to_highlight = 1,
					-- case_insensitive_regex: sets regex case sensitivity
					case_insensitive_regex = false,
				})

				vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#525252" })
				vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#525252" })
				vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#525252" })
			end,
		},
	},
	opts = {
		---@usage 'background'|'foreground'|'virtual'
		render = "virtual",

		---Set virtual symbol (requires render to be set to 'virtual')
		virtual_symbol = "",

		---Highlight named colors, e.g. 'green'
		enable_named_colors = true,

		---Set custom colors
		---Label must be properly escaped with '%' to adhere to `string.gmatch`
		--- :help string.gmatch
		custom_colors = {
			{ label = "%-%-theme%-primary%-color", color = "#0f1219" },
			{ label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
		},
	},
}
