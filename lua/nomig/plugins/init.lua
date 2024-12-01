return {
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({
				easing = "cubic",
			})

			local duration = 50
			local neoscroll = require("neoscroll")
			local keymap = {
				["<C-u>"] = function()
					neoscroll.ctrl_u({ duration = duration })
				end,
				["<C-d>"] = function()
					neoscroll.ctrl_d({ duration = duration })
				end,
				["<C-b>"] = function()
					neoscroll.ctrl_b({ duration = duration * 2 })
				end,
				["<C-f>"] = function()
					neoscroll.ctrl_f({ duration = duration * 2 })
				end,
				["<C-y>"] = function()
					neoscroll.scroll(-0.1, { move_cursor = false, duration = duration / 2 })
				end,
				["<C-e>"] = function()
					neoscroll.scroll(0.1, { move_cursor = false, duration = duration / 2 })
				end,
				["zt"] = function()
					neoscroll.zt({ half_win_duration = duration })
				end,
				["zz"] = function()
					neoscroll.zz({ half_win_duration = duration })
				end,
				["zb"] = function()
					neoscroll.zb({ half_win_duration = duration })
				end,
			}
			local modes = { "n", "v", "x" }
			for key, func in pairs(keymap) do
				vim.keymap.set(modes, key, func)
			end
		end,
	},
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
