return {
	"OXY2DEV/markview.nvim",
	ft = "markdown",
	-- branch = "dev",

	config = function()
		vim.keymap.set("n", "<leader>md", "<cmd>Markview<CR>")
		require("markview").setup({
			modes = { "n", "no", "i" },
			-- hybrid_modes = { "n", "no", "i" },
			list_items = {
				shift_width = 2,
			},
			checkboxes = {
				unchecked = { text = "", hl = "Error" },
				checked = { text = "", hl = "GitSignsAdd" },
			},
		})
        vim.cmd("Markview")
	end,
}
