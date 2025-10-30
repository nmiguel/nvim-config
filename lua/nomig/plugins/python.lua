return {
	{
		"benomahony/uv.nvim",
        enabled = false,
        dependencies = {
            "folke/snacks.nvim",
        },
        ft = "python",
		config = function()
			require("uv").setup({
                picker_integration = true,
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
