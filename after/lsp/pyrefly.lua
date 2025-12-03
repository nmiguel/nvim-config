return {
	cmd = { "pyrefly", "lsp" },
	filetypes = { "python" },
	root_dir = function(bufnr, cb)
		local root = vim.fs.root(bufnr, {
			"pyrefly.roml",
			"pyrefly.toml",
		}) or vim.fn.expand("%:p:h")
		cb(root)
	end,
	on_attach = function(client, _)
		client.server_capabilities.codeActionProvider = false -- basedpyright has more kinds
		client.server_capabilities.documentSymbolProvider = false -- basedpyright has more kinds
		client.server_capabilities.hoverProvider = false -- basedpyright has more kinds
		client.server_capabilities.inlayHintProvider = false -- basedpyright has more kinds
		client.server_capabilities.referenceProvider = false -- basedpyright has more kinds
		client.server_capabilities.signatureHelpProvider = false -- basedpyright has more kinds
		client.server_capabilities.semanticTokensProvider = nil
		client.handlers["textDocument/publishDiagnostics"] = function() end
	end,
	settings = {
		python = {
			pyrefly = {
				displayTypeErrors = "force-off",
			},
		},
	},
}
