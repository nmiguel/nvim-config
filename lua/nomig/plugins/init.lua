return {
	"stevearc/dressing.nvim",
	{
		"levouh/tint.nvim",
		opts = {},
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
	{
		"svban/YankAssassin.nvim",
		config = function()
			require("YankAssassin").setup({
				auto = true,
			})
		end,
	},
	{
		"prichrd/netrw.nvim",
		opts = {
			-- Put your configuration here, or leave the object empty to take the default
			-- configuration.
			icons = {
				symlink = "", -- Symlink icon (directory and file)
				directory = "", -- Directory icon
				file = "", -- File icon
			},
			use_devicons = true, -- Uses nvim-web-devicons if true, otherwise use the file icon specified above
			mappings = {}, -- Custom key mappings}
		},
	},
}
