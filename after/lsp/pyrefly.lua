return {
	cmd = { "pyrefly", "lsp" },
	filetypes = { "python" },
	root_dir = function(bufnr, cb)
		local root = vim.fs.root(bufnr, {
			"pyrefly.toml",
			"pyproject.toml",
			"pyrightconfig.json",
			".git",
		}) or vim.fn.expand("%:p:h")
		cb(root)
	end,
	on_attach = function(client, _)
		-- Suppress all pyrefly diagnostics; ruff handles linting
		client.handlers["textDocument/publishDiagnostics"] = function() end
	end,
	settings = {
		python = {
			pyrefly = {
				typeCheckingMode = "basic",
				disableTypeErrors = true,
				analysis = {
					diagnosticMode = "openFilesOnly",
					inlayHints = {
						variableTypes = true,
						callArgumentNames = "all", -- "off" to disable, "all" to enable
						functionReturnTypes = true,
						pytestParameters = false,
					},
				},
			},
		},
	},
}
