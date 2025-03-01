return {
	{
		"refractalize/oil-git-status.nvim",

		dependencies = {
			"stevearc/oil.nvim",
		},

		config = true,
	},
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			win_options = {
				signcolumn = "yes:1",
			},

			keymaps = {
				["q"] = { "actions.close", mode = "n" },
			},
			view_options = {
				show_hidden = true,
			},
		},
		keys = {
			{ mode = "n", "-", "<cmd>Oil<CR>", { noremap = true, silent = true, description = "Open Oil" } },
			{ mode = "n", "<leader>-", "<cmd>Oil .<CR>", { noremap = true, silent = true, description = "Open Oil in CWD" } },
		},

		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	},
}
