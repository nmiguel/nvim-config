return {
	"nmiguel/jot.lua",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<leader>td",
			function() require('jot').open()
            end,
			mode = "n",
			desc = "Open jot",
		},
	},
	opts = {
		quit_key = "q",
		notes_dir = vim.fn.stdpath("data") .. "/jot",
		win_opts = {
			relative = "editor",
			width = 36,
			height = 100,
			anchor = "NE",
			row = 0,
			col = vim.api.nvim_list_uis()[1].width - 36,
			-- split = "right",
			focusable = false,
		},
	},
}
