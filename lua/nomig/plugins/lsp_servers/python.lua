vim.lsp.config.basedpyright = {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { "pyrightconfig.json", "pyproject.toml", "Pipfile", "setup.py", "setup.cfg", ".git" },
	settings = {
		basedpyright = {
			disableOrganizeImports = true,
			disableTaggedHints = true,
			analysis = {
				autoImportCompletions = true,
				diagnosticMode = "openFilesOnly",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				typeCheckingMode = "basic",
				inlayHints = {
					variableTypes = true,
					callArgumentNames = true,
					functionReturnTypes = true,
					genericTypes = false,
				},
				diagnosticSeverityOverrides = {
					reportIgnoreCommentWithoutRule = true,
				},
				ignore = { "*" },
				exclude = { "**/venv", "**/__pycache__" },
			},
		},
	},
}

local capabilities = require("blink.cmp").get_lsp_capabilities()
local ruff_capabilities = vim.tbl_deep_extend("force", {}, capabilities)
ruff_capabilities.hoverProvider = false
vim.lsp.config.ruff = {
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

vim.lsp.enable("basedpyright")
vim.lsp.enable("ruff")
