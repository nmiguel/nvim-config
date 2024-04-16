return {
	"stevearc/dressing.nvim",
	{
		"numToStr/Comment.nvim",
		event = { "BufWritePost", "BufReadPost", "InsertEnter" },
		config = function()
			require("Comment").setup()
		end,
	},

	{
		"echasnovski/mini.surround",
		event = { "VeryLazy" },
		version = "*",
		config = function()
			require("mini.surround").setup({})
		end,
	},
	{
		"kana/vim-textobj-entire",
		event = { "VeryLazy" },
		dependencies = { "kana/vim-textobj-user" },
	},
}
