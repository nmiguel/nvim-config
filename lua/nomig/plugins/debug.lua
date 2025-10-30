return {
	"andrewferrier/debugprint.nvim",
	dependencies = {
        "echasnovski/mini.hipatterns",
        "folke/snacks.nvim",
	},
	event = "VeryLazy",
	config = function()
		require("debugprint").setup({ picker = "snacks.picker" })
		vim.keymap.set("n", "<leader>pd", "<cmd>Debugprint search<CR>")
	end,
}
