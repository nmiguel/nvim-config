return {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<C-j>",
				clear_suggestion = "<C-]>",
				accept_word = "<C->>",
			},
		})

		vim.keymap.set("n", "<leader>cd", function()
			vim.cmd("SupermavenStop")
			vim.notify("Supermaven stopped")
		end, { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>ce", function()
			vim.cmd("SupermavenStart")
			vim.notify("Supermaven started")
		end, { noremap = true, silent = true })
	end,
}
