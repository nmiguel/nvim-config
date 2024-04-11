return {
	"danymat/neogen",
	config = true,
	-- Uncomment next line if you want to follow only stable versions
	-- version = "*"

	keys = {
		{
			"<leader>df",
            mode = "n",
			function() require('neogen').generate({type = "func"}) end,
			{ noremap = true, silent = true },
		},
		{
			"<leader>dc",
            mode = "n",
			function() require('neogen').generate({type = "class"}) end,
			{ noremap = true, silent = true },
		},
	},
	opts = {
		enabled = true,
		languages = {
			python = {
				template = {
					annotation_convention = "reST",
				},
			},
		},
	},
}
