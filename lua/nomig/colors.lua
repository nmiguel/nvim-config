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

M.apply = function(user_colors)
  local colors = vim.tbl_deep_extend("force", defaults, user_colors or {})
  local hl = vim.api.nvim_set_hl

  -- core UI
  hl(0, "StatusLine", { fg = colors.statusLineFg, bg = "none" })
  hl(0, "LineNr", { fg = colors.lineNrFg, bg = "none" })
  hl(0, "WinSeparator", { fg = colors.winSeparatorFg, bg = "none" })

  -- git
  hl(0, "GitSignsAdd", { fg = colors.gitAddFg, bg = "none" })
  hl(0, "GitSignsChange", { fg = colors.gitChangeFg, bg = "none" })

  -- diagnostics
  hl(0, "DiagnosticVirtualTextInfo", { fg = colors.diagnosticInfoFg, bg = "none" })
  hl(0, "DiagnosticVirtualTextWarn", { fg = colors.diagnosticWarnFg, bg = "none" })
  hl(0, "DiagnosticVirtualTextError", { fg = colors.diagnosticErrorFg, bg = "none" })
  hl(0, "DiagnosticVirtualTextHint", { fg = colors.diagnosticHintFg, bg = "none" })

  -- misc
  hl(0, "DebugPrintLine", { fg = colors.debugPrintFg, bg = "none", italic = true })
  hl(0, "BlinkCmpLabelMatch", { fg = colors.blinkMatchFg, bg = "none" })
  hl(0, "LspInlayHint", { fg = colors.inlayHintFg, bg = "none", italic = true })

  -- mini.hipatterns
  hl(0, "MiniHipatternsFixme", { fg = colors.miniFixmeFg, bg = "none", italic = true })
  hl(0, "MiniHipatternsHack", { fg = colors.miniHackFg, bg = "none", italic = true })
  hl(0, "MiniHipatternsTodo", { fg = colors.miniTodoFg, bg = "none", italic = true })
  hl(0, "MiniHipatternsNote", { fg = colors.miniNoteFg, bg = "none", italic = true })

  -- always transparent
  hl(0, "WinBar", { bg = "none" })
  hl(0, "WinBarNC", { bg = "none" })
  hl(0, "Pmenu", { bg = "none" })
  hl(0, "BlinkCmpMenu", { bg = "none" })
  hl(0, "TabLine", { bg = "none" })
  hl(0, "TabLineFill", { bg = "none" })
  hl(0, "TabLineSel", { bg = "none" })
end

return M
