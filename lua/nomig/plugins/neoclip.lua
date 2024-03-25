return {
	"AckslD/nvim-neoclip.lua",
	dependencies = {
		{ "nvim-telescope/telescope.nvim" },
	},
	lazy = false,  -- needs to always be loaded
	keys = {
		{
			mode = "n",
			"<leader>pp",
			"<cmd>Telescope neoclip<cr>",
		},
	},
	config = function()
		require("neoclip").setup({
			-- enable_persistent_history = false,
			-- db_path = vim.fn.expand("$HOME/neoclip.sqlite3")
			keys = {
				telescope = {
                    -- <cr> rather than <C-P> (which is previous)
					i = {
						paste = "<cr>",
					},
				},
			},
		})
		require("neoclip").start()
	end,
}
