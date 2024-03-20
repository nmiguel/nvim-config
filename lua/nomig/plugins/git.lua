return {
	"SuperBo/fugit2.nvim",
	opts = {},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
		{
			"chrisgrieser/nvim-tinygit",
			dependencies = { "stevearc/dressing.nvim" },
		},
	},
	cmd = { "Fugit2", "Fugit2Graph" },
	keys = {
		{ "<leader>gs", mode = "n", "<cmd>Fugit2<cr>" },
	},
	-- "kdheepak/lazygit.nvim",
	-- -- optional for floating window border decoration
	-- dependencies = {
	--     "nvim-lua/plenary.nvim",
	-- },
	-- event = "VeryLazy",
	-- keys = {
	--     { "<leader>gs",
	--     mode = "n",
	--     "<cmd>LazyGit<cr>" }
	-- }
	--
}
