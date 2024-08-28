return {
	"ptdewey/yankbank-nvim",
	events = "VeryLazy",
	config = function()
		require("yankbank").setup({
			max_entries = 9,
			num_behavior = "jump",
		})
		vim.api.nvim_set_keymap("n", "<leader>pp", "<cmd>YankBank<cr>", { noremap = true, silent = true })
	end,
}
