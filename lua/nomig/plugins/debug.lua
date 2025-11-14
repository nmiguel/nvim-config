return {
	"andrewferrier/debugprint.nvim",
	dependencies = {
		"folke/snacks.nvim",
	},
	event = "VeryLazy",
	config = function()
		require("debugprint").setup({ picker = "snacks.picker", highlight_lines = false })
		vim.keymap.set("n", "<leader>pd", "<cmd>Debugprint search<CR>")
	end,
}
