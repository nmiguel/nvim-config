return {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_dir = function(bufnr, cb)
		local root = vim.fs.root(bufnr, {
			"pyproject.toml",
			"pyrightconfig.json",
			".git",
		}) or vim.fn.expand("%:p:h")
		cb(root)
	end,
	on_attach = function(client, _)
        -- Keep these true while pyrefly crashes often
		client.server_capabilities.completionProvider = false -- use pyrefly for fast response
		client.server_capabilities.definitionProvider = false -- use pyrefly for fast response
        client.server_capabilities.referencesProvider = false

		client.server_capabilities.documentHighlightProvider = false -- use pyrefly for fast response
		client.server_capabilities.renameProvider = false -- use pyrefly as I think it is stable
		client.server_capabilities.semanticTokensProvider = false -- use pyrefly it is more rich
	end,
	settings = {
		basedpyright = {
			disableOrganizeImports = true,
			disableTaggedHints = true,
			analysis = {
				autoImportCompletions = true,
				diagnosticMode = "openFilesOnly",
				autoSearchPaths = false,
				useLibraryCodeForTypes = false,
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
				exclude = { "**/venv", "**/.venv", "**/__pycache__" },
			},
		},
	},
}
