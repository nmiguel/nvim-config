return {
	"nmiguel/jqscratch.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			mode = "n",
			"<leader>pj",
			function()
				require("jqscratch").toggle()
			end,
			{ noremap = true, silent = true },
		},
	},
	opts = {},
}
