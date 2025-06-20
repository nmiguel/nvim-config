local capabilities = require("blink.cmp").get_lsp_capabilities()
local ruff_capabilities = vim.tbl_deep_extend("force", {}, capabilities)
ruff_capabilities.hoverProvider = false
return {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	init_options = {
		settings = {
			fixAll = false,
			organizeImports = false,
			configurationPreference = "editorOnly",
			lint = { ignore = { "E741" } },
		},
	},
	capabilities = ruff_capabilities,
}

