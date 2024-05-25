return {
	"letieu/jot.lua",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<leader>td",
			function()
				require("jot").open()
			end,
			mode = "n",
			desc = "Open jot",
		},
	},
	opts = {
		quit_key = "q",
		notes_dir = vim.fn.stdpath("data") .. "/jot",
		win_opts = {
			split = "right",
			focusable = false,
            width = 80,
		},
	},
}
