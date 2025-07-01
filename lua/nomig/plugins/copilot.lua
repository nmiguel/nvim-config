return {
	"supermaven-inc/supermaven-nvim",
	keys = {
		{
			mode = "n",
			"<leader>cd",
			function()
				vim.cmd("SupermavenStop")
				vim.notify("Supermaven stopped")
			end,
			desc = "Stop Supermaven",
		},
		{
			mode = "n",
			"<leader>ce",
			function()
				vim.cmd("SupermavenStart")
				vim.notify("Supermaven started")
			end,
			desc = "Start Supermaven",
		},
	},
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<C-j>",
				clear_suggestion = "<C-]>",
				accept_word = "<C->>",
			},
		})
	end,
}
