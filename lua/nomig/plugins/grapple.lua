return {
	"cbochs/grapple.nvim",
    enabled = false,
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", lazy = true },
	},
	keys = {
		{
			"<leader>j",
			mode = "n",
			function()
				require("grapple").cycle_tags("next", {})
			end,
		},
		{
			"<leader>f",
			mode = "n",
			function()
				require("grapple").cycle_tags("prev", {})
			end,
		},
		{
			"<leader>h",
			mode = "n",
			function()
				require("grapple").open_tags()
			end,
		},
		{
			"<leader>a",
			mode = "n",
			function()
				require("grapple").toggle()
			end,
		},
	},
	opts = {
		scope = "cwd",
	},
}
