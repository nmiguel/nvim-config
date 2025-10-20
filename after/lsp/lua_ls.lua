return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			diagnostics = {
				disable = { "missing-fields", "incomplete-signature-doc" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					[vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types"] = true,
					[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
					[vim.fn.expand("${3rd}/love2d/library")] = true,
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
			codeLens = {
				enable = true,
			},
			doc = {
				privateName = { "^_" },
			},
			hint = {
				enable = true,
				setType = false,
				paramType = true,
				paramName = "Disable",
				semicolon = "Disable",
				arrayIndex = "Disable",
			},
		},
	},
}
