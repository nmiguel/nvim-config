local M = {}

local defaults = {
	lineNrFg = "#5eacd3",
	statusLineFg = "#c0caf5",
	winSeparatorFg = "#5eacd3",

	gitAddFg = "#9ece6a",
	gitChangeFg = "#7aa2f7",

	diagnosticInfoFg = "#7dcfff",
	diagnosticWarnFg = "#e0af68",
	diagnosticErrorFg = "#f7768e",
	diagnosticHintFg = "#1abc9c",

	blinkMatchFg = "#bb9af7",
	inlayHintFg = "#565f89",
	debugPrintFg = "#bb9af7",

	miniFixmeFg = "#f7768e",
	miniHackFg = "#9ece6a",
	miniTodoFg = "#7dcfff",
	miniNoteFg = "#1abc9c",
}

local function set_partial_hl(name, opts)
	local current = vim.api.nvim_get_hl(0, { name = name })

	-- normalize (nvim returns integers sometimes)
	local function normalize(color)
		if type(color) == "number" then
			return string.format("#%06x", color)
		end
		return color
	end

	local merged = {
		fg = opts.fg ~= nil and opts.fg or normalize(current.fg),
		bg = opts.bg ~= nil and opts.bg or normalize(current.bg),
		bold = opts.bold ~= nil and opts.bold or current.bold,
		italic = opts.italic ~= nil and opts.italic or current.italic,
		underline = opts.underline ~= nil and opts.underline or current.underline,
		reverse = opts.reverse ~= nil and opts.reverse or current.reverse,
		standout = opts.standout ~= nil and opts.standout or current.standout,
		strikethrough = opts.strikethrough ~= nil and opts.strikethrough or current.strikethrough,
	}

	vim.api.nvim_set_hl(0, name, merged)
end

M.apply = function(user_colors)
	local colors = vim.tbl_deep_extend("force", defaults, user_colors or {})

	-- core UI
	set_partial_hl("StatusLine", { fg = colors.statusLineFg, bg = "none" })
	set_partial_hl("LineNr", { fg = colors.lineNrFg, bg = "none" })
	set_partial_hl("WinSeparator", { fg = colors.winSeparatorFg, bg = "none" })

	set_partial_hl("Normal", { bg = "none" })
	set_partial_hl("NormalNC", { bg = "none" })
	set_partial_hl("NormalFloat", { bg = "none" })
	set_partial_hl("FloatBorder", { bg = "none" })
	set_partial_hl("FloatTitle", { bg = "none" })

	-- git
	set_partial_hl("GitSignsAdd", { fg = colors.gitAddFg, bg = "none" })
	set_partial_hl("GitSignsChange", { fg = colors.gitChangeFg, bg = "none" })

	-- diagnostics
	set_partial_hl("DiagnosticVirtualTextInfo", { fg = colors.diagnosticInfoFg, bg = "none" })
	set_partial_hl("DiagnosticVirtualTextWarn", { fg = colors.diagnosticWarnFg, bg = "none" })
	set_partial_hl("DiagnosticVirtualTextError", { fg = colors.diagnosticErrorFg, bg = "none" })
	set_partial_hl("DiagnosticVirtualTextHint", { fg = colors.diagnosticHintFg, bg = "none" })

	-- misc
	set_partial_hl("DebugPrintLine", { fg = colors.debugPrintFg, bg = "none", italic = true })
	set_partial_hl("BlinkCmpLabelMatch", { fg = colors.blinkMatchFg, bg = "none" })
	set_partial_hl("LspInlayHint", { fg = colors.inlayHintFg, bg = "none", italic = true })

	-- mini.hipatterns
	set_partial_hl("MiniHipatternsFixme", { fg = colors.miniFixmeFg, bg = "none", italic = true })
	set_partial_hl("MiniHipatternsHack", { fg = colors.miniHackFg, bg = "none", italic = true })
	set_partial_hl("MiniHipatternsTodo", { fg = colors.miniTodoFg, bg = "none", italic = true })
	set_partial_hl("MiniHipatternsNote", { fg = colors.miniNoteFg, bg = "none", italic = true })

	-- Slimline
	set_partial_hl("SlimlinePrimarySep", { bg = "none" })
	set_partial_hl("SlimlineSecondarySep", { bg = "none" })

	-- always transparent
	set_partial_hl("WinBar", { bg = "none" })
	set_partial_hl("WinBarNC", { bg = "none" })
	set_partial_hl("Pmenu", { bg = "none" })
	set_partial_hl("BlinkCmpMenu", { bg = "none" })
	set_partial_hl("BlinkCmpDoc", { bg = "none" })
	set_partial_hl("TabLine", { bg = "none" })
	set_partial_hl("TabLineFill", { bg = "none" })
	set_partial_hl("TabLineSel", { bg = "none" })
end

return M
