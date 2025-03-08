return {
	{
		"maxandron/goplements.nvim",
		ft = "go",
		opts = {
			prefix = {
				interface = " implemented by: ",
				struct = " implements: ",
			},
			-- highlight = "Special",
		},
	},
	{
		"fredrikaverpil/godoc.nvim",
		version = "*",
		dependencies = {
			{ "folke/snacks.nvim" },

			{
				"nvim-treesitter/nvim-treesitter",
				opts = {
					ensure_installed = { "go" },
				},
			},
		},
		build = "go install github.com/lotusirous/gostdsym/stdsym@latest",
		cmd = { "GoDoc" },
		opts = {
			picker = {
				type = "snacks",
				snacks = {},
			},
		},
	},
	{
		"leoluz/nvim-dap-go",
        ft = "go",
		config = function()
			require("dap-go").setup()
		end,
	},
}
