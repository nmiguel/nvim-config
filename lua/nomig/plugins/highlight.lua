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
					delay = 100,
					filetypes_denylist = {
						"dirbuf",
						"dirvish",
						"fugitive",
                        "aerial",
                        "netrw",
                        "lazy",
                        "mason",
					},
					-- under_cursor: whether or not to illuminate under the cursor
					under_cursor = true,
					min_count_to_highlight = 2,
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
