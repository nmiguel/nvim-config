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
		"mfussenegger/nvim-dap-python",
		ft = "python",
        enabled = false,
		config = function()
			require("dap-python").setup("python3")
		end,
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-treesitter/nvim-treesitter",
		},
	},
}
