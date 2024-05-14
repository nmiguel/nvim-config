function MyTheme()
	-- lsp virtual text bg
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { bg = "none", fg = "#993939" })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { bg = "none", fg = "#93691d" })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { bg = "none", fg = "#2b6f77" })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { bg = "none", fg = "#8a3fa0" })
	vim.api.nvim_set_hl(0, "LspDiagnosticsVirtualTextError", { link = "DiagnosticVirtualTextError" })
	vim.api.nvim_set_hl(0, "LspDiagnosticsVirtualTextWarn", { link = "DiagnosticVirtualTextWarn" })
	vim.api.nvim_set_hl(0, "LspDiagnosticsVirtualTextInfo", { link = "DiagnosticVirtualTextInfo" })
	vim.api.nvim_set_hl(0, "LspDiagnosticsVirtualTextHint", { link = "DiagnosticVirtualTextHint" })
	--cmp fixes
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#aaaaaa", bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

	vim.api.nvim_set_hl(0, "PMenu", { bg = "none" })
	vim.api.nvim_set_hl(0, "PMenuSel", { bg = "none" })
	vim.api.nvim_set_hl(0, "PMenuSBar", { fg = "none", bg = "none" })
	vim.api.nvim_set_hl(0, "PMenuThumb", { bg = "#aaaaaa" })
	-- gray
	vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
	-- blue
	vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
	vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
	-- light blue
	vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
	vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
	vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
	-- pink
	vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
	vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
	-- front
	vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
	vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
	vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })
end

return {
	{
		"navarasu/onedark.nvim",
		lazy = false,
		name = "my_theme",
		config = function()
			require("onedark").setup({
				transparent = true,
			})

			vim.cmd("colorscheme onedark")

			MyTheme()
		end,
	},
}
