return {
	"stevearc/dressing.nvim",
	"tpope/vim-vinegar",
	{
		"levouh/tint.nvim",
		enabled = false,
		opts = {},
	},
	-- { "plax-00/endscroll.nvim", opts = {} },
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
	{
		"meznaric/key-analyzer.nvim",
		config = function()
			require("key-analyzer").setup({
				-- Name of the command to use for the plugin
				command_name = "KeyAnalyzer", -- or nil to disable the command

				-- Customize the highlight groups
				highlights = {
					bracket_used = "KeyAnalyzerBracketUsed",
					letter_used = "KeyAnalyzerLetterUsed",
					bracket_unused = "KeyAnalyzerBracketUnused",
					letter_unused = "KeyAnalyzerLetterUnused",
					promo_highlight = "KeyAnalyzerPromo",

					-- Set to false if you want to define highlights manually
					define_default_highlights = true,
				},
			})
		end,
	},
}
