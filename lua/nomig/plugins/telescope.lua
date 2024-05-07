return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	lazy = false,
	keys = {
		{ mode = "n", "<leader>pf", require("telescope.builtin").find_files },
		{
			mode = "n",
			"<leader>paf",
			function()
				require("telescope.builtin").find_files({ no_ignore = true })
			end,
		},
		{ mode = "n", "<leader>ps", require("telescope.builtin").live_grep },
		{ mode = "n", "<leader>ds", require("telescope.builtin").help_tags },
	},
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<esc>"] = actions.close,
					},
				},
                path_display ={  "filename_first" },
			},
		})
	end,
}
