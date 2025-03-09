return {
	"sschleemilch/slimline.nvim",
	version = "1.2.x",
	dependencies = {
		"cbochs/grapple.nvim",
	},
	config = function()
		vim.opt.laststatus = 3
		require("slimline").setup({
			bold = false, -- makes primary parts and mode bold
			verbose_mode = false, -- Mode as single letter or as a word
			style = "bg", -- or "fg". Whether highlights should be applied to bg or fg of components
			components = { -- Choose components and their location
				left = {
					"mode",
					"path",
					"diagnostics",
				},
				center = {},
				right = {
					"git",
					function()
						local h = require("slimline.highlights")
						local c = require("slimline").config
						local primary = require("grapple").statusline({ include_icon = false })
						if #primary == 0 then
							return ""
						end
						local secondary = "󰛢"

						return h.hl_component({ primary = primary, secondary = secondary }, h.hls.component, c.sep)
					end,
					"filetype_lsp",
					-- "progress",
				},
			},
			spaces = {
				components = " ", -- string between components
				left = " ", -- string at the start of the line
				right = " ", -- string at the end of the line
			},
			sep = {
				hide = {
					first = false, -- hides the first separator
					last = false, -- hides the last separator
				},
				left = "", -- left separator of components
				right = "", -- right separator of components
			},
			hl = {
				modes = {
					normal = "@keyword.function", -- highlight base of modes
					insert = "Function",
					pending = "Type",
					visual = "Keyword",
					command = "String",
				},
				base = "Comment", -- highlight of everything in in between components
				primary = "Normal", -- highlight of primary parts (e.g. filename)
				secondary = "Comment", -- highlight of secondary parts (e.g. filepath)
			},
			icons = {
				diagnostics = {
					ERROR = " ",
					WARN = " ",
					HINT = " ",
					INFO = " ",
				},
				git = {
					branch = "",
				},
				folder = "",
				lines = " ",
			},
		})
	end,
}
