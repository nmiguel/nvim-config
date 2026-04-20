return {
	cmd = { "ty", "server" },
	filetypes = { "python" },
	root_markers = { "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
	settings = {
		ty = {
			diagnosticMode = "openFilesOnly",
			configuration = {
				rules = {
					["invalid-argument-type"] = "ignore",
					["invalid-assignment"] = "ignore",
					["invalid-attribute-access"] = "ignore",
					["invalid-return-type"] = "ignore",
					["invalid-yield"] = "ignore",
					["no-matching-overload"] = "ignore",
					["unresolved-attribute"] = "ignore",
				},
			},
		},
	},
}
