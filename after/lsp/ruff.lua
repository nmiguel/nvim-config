return {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	on_attach = function(client)
		client.server_capabilities.hoverProvider = false
	end,
	init_options = {
		settings = {
			fixAll = false,
			organizeImports = false,
			configurationPreference = "editorOnly",
			lint = { ignore = { "E741" } },
		},
	},
}
