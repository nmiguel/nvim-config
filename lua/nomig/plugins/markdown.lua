return {
	{
		"yousefhadder/markdown-plus.nvim",
		ft = "markdown",
		opts = {},
	},
	{
		"meanderingprogrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
		-- ft = "markdown",
		keys = {
			{
				"<leader>md",
				mode = "n",
				function()
					require("render-markdown").toggle()
				end,
			},
		},
		opts = { enabled = false },
	},
}
