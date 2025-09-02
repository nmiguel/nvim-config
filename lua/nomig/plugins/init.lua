return {
	{
		"kwkarlwang/bufjump.nvim",
		config = function()
			require("bufjump").setup({
				forward_key = "<a-i>",
				backward_key = "<a-o>",
				on_success = nil,
			})
		end,
	},
	{
		"karb94/neoscroll.nvim",
		enabled = false,
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
	{
		"2kabhishek/nerdy.nvim",
		dependencies = {
			"folke/snacks.nvim",
		},
		cmd = "Nerdy",
		opts = {
			max_recents = 30,
			add_default_keybindings = false,
			copy_to_clipboard = false,
		},
	},
	{
		"levouh/tint.nvim",
		enabled = false,
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
}
