return {
	{
		"benomahony/uv.nvim",
		config = function()
			require("uv").setup({
                keymaps = false,
            })
		end,
	},
	{
		"fredrikaverpil/pydoc.nvim",
		dependencies = {
			{ "folke/snacks.nvim" },
			{
				"nvim-treesitter/nvim-treesitter",
				opts = {
					ensure_installed = { "markdown" },
				},
			},
		},
		cmd = { "PyDoc" },
		opts = {
			picker = {
				type = "snacks",
				snacks = {},
			},
		},
	},

	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		config = function()
			require("dap-python").setup("python3")
		end,
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-treesitter/nvim-treesitter",
		},
	},
}
