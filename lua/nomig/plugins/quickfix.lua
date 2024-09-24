return {
	"stevearc/quicker.nvim",
	event = "FileType qf",
	keys = {
		{
			mode = "n",
			"<leader>q",
			function()
				require("quicker").toggle()
			end,
		},
	},
	opts = {
		borders = {
			vert = "|",
		},
	},
}
