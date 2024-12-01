---@diagnostic disable: undefined-global
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		require("snacks").setup({
			styles = {},
			words = { enabled = true },
			notifier = { enabled = false },
			quickfile = { enabled = false },

			bigfile = { enabled = true },
			statuscolumn = { enabled = true },
		})
		vim.api.nvim_create_user_command("Github", function()
			Snacks.gitbrowse()
		end, {})
	end,
	keys = {
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
