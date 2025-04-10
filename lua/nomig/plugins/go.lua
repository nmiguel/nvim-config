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
		"leoluz/nvim-dap-go",
        ft = "go",
		config = function()
			require("dap-go").setup()
		end,
	},
}
