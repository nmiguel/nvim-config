return {
	{
		"nmiguel/bosana.nvim",
		opts = {},
		commands = {
			{
				"Bosana",
				function()
					require("bosana").open()
				end,
				desc = "Open Bosana",
			},
		},
	},
}
