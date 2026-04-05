-- Lsp Log
vim.api.nvim_create_user_command("LspLog", function(_)
	local state_path = vim.fn.stdpath("state")
	local log_path = vim.fs.joinpath(state_path, "lsp.log")

	vim.cmd(string.format("edit %s", log_path))
end, {
	desc = "Show LSP log",
})

-- Open help in vertical split
vim.cmd("cnorea h vert bo help")

-- LspInfo
vim.cmd("cnorea LspInfo checkhealth vim.lsp")
