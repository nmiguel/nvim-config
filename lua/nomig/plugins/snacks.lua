---@diagnostic disable: undefined-global
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		styles = {},
        words = { enabled = true },
        notifier = { enabled = false },
        quickfile = { enabled = false },

		bigfile = { enabled = true },
		statuscolumn = { enabled = true },
	},
	keys = {
		{
			"<leader>gh",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Open Remote",
		},
		{
			"<leader>gf",
			function()
				Snacks.lazygit.log_file()
			end,
			desc = "Lazygit log file",
		},
		{
			"<leader>gs",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
	},
}
