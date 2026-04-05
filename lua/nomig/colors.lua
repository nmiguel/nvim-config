local M = {}

local defaults = {
	lineNrFg = "#3b4261",
	floatBorder = "#aba2a1",
	cursorLineNrFg = "#ffc777",
	statusLineFg = "#c0caf5",
	winSeparatorFg = "#c0caf5",

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

local function update_hl(name, opts)
	opts.update = true
	vim.api.nvim_set_hl(0, name, opts)
end

local function make_transparent(names)
	for _, name in ipairs(type(names) == "table" and names or { names }) do
		vim.api.nvim_set_hl(0, name, { bg = "none", update = true })
	end
end

M.apply = function(user_colors)
	local colors = vim.tbl_deep_extend("force", defaults, user_colors or {})

	-- core UI
	update_hl("StatusLine", { fg = colors.statusLineFg, bg = "none" })
	update_hl("LineNr", { fg = colors.lineNrFg, bg = "none" })
	update_hl("CursorLineNr", { fg = colors.cursorLineNrFg, bg = "none", bold = true })
	update_hl("WinSeparator", { fg = colors.winSeparatorFg, bg = "none" })
	update_hl("FloatBorder", { fg = colors.floatBorder, bg = "none" })

	-- diagnostics
	update_hl("DiagnosticVirtualTextInfo", { fg = colors.diagnosticInfoFg, bg = "none" })
	update_hl("DiagnosticVirtualTextWarn", { fg = colors.diagnosticWarnFg, bg = "none" })
	update_hl("DiagnosticVirtualTextError", { fg = colors.diagnosticErrorFg, bg = "none" })
	update_hl("DiagnosticVirtualTextHint", { fg = colors.diagnosticHintFg, bg = "none" })

	-- misc
	update_hl("DebugPrintLine", { fg = colors.debugPrintFg, bg = "none", italic = true })
	update_hl("BlinkCmpLabelMatch", { fg = colors.blinkMatchFg, bg = "none" })
	update_hl("LspInlayHint", { fg = colors.inlayHintFg, bg = "none", italic = true })
	update_hl("Folded", { italic = true, bg = "none" })

	-- mini.hipatterns
	update_hl("MiniHipatternsFixme", { fg = colors.miniFixmeFg, bg = "none", italic = true })
	update_hl("MiniHipatternsHack", { fg = colors.miniHackFg, bg = "none", italic = true })
	update_hl("MiniHipatternsTodo", { fg = colors.miniTodoFg, bg = "none", italic = true })
	update_hl("MiniHipatternsNote", { fg = colors.miniNoteFg, bg = "none", italic = true })
	update_hl("LspReferenceRead", { bg = "none", italic = true, bold = true, underline = false })
	update_hl("LspReferenceWrite", { bg = "none", italic = true, bold = true, underline = true })
	update_hl("LspReferenceText", { bg = "none", italic = true, bold = true, underline = false })
    update_hl("MsgSeparator", {bg = "none", underline = true, fg = colors.statusLineFg})

	-- always transparent
	make_transparent({
		"Normal",
		"NormalFloat",
		"FloatBorder",
		"FloatTitle",
		"EndOfBuffer",
		"WinSeparator",
		"SignColumn",

		"GitSignsAdd",
		"GitSignsChange",
		"GitSignsDelete",
		"GitSignsAdd",
		"GitSignsStagedChangedeleteCul",
		"GitSignsStagedChangedeleteNr",
		"GitSignsStagedUntrackedCul",
		"GitSignsStagedTopdeleteCul",
		"GitSignsStagedChangedelete",
		"GitSignsStagedUntrackedNr",
		"GitSignsStagedTopdeleteNr",
		"GitSignsStagedUntracked",
		"GitSignsStagedTopdelete",
		"GitSignsStagedDeleteCul",
		"GitSignsStagedChangeCul",
		"GitSignsStagedDeleteNr",
		"GitSignsStagedChangeNr",
		"GitSignsStagedDelete",
		"GitSignsStagedChange",
		"GitSignsStagedAddCul",
		"GitSignsStagedAddNr",
		"GitSignsStagedAdd",
		"GitSignsStagedChangedeleteLn",
		"GitSignsStagedUntrackedLn",
		"GitSignsStagedChangeLn",
		"GitSignsStagedAddLn",
		"OilGitStatusIndex",

		"GitSignsChange",
		"GitSignsDelete",
		"SlimlinePrimarySep",
		"Slimline",
		"SlimlineSecondarySep",
		"WinBar",
		"WinBarNC",
		"Pmenu",
		"BlinkCmpMenu",
		"BlinkCmpMenuBorder",
		"BlinkCmpDoc",
		"TabLine",
		"TabLineFill",
		"TabLineSel",
	})
end

return M
