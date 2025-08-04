return {
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
