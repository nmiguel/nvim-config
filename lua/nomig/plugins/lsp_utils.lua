return {
	{
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		event = "LspAttach",
		enabled = false, -- Needs to be updated to 0.11
		config = function()
			require("tiny-code-action").setup()
			vim.keymap.set(
				{ "n", "v" },
				"<leader>va",
				"<cmd>lua require('tiny-code-action').code_action()<cr>",
				{ noremap = true, silent = true }
			)
		end,
	},
	{
		"kosayoda/nvim-lightbulb",
		event = "LspAttach",
		enabled = false, -- Needs to be updated to 0.11
		config = function()
			vim.api.nvim_set_hl(0, "LightBulbSign", { fg = "#FFA500", bg = "none" })
			require("nvim-lightbulb").setup({
				autocmd = { enabled = true },
				sign = {
					enabled = true,
					-- Text to show in the sign column.
					-- Must be between 1-2 characters.
					text = "",
					-- Highlight group to highlight the sign column text.
					hl = "LightBulbSign",
				},
			})
		end,
	},
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		ft = "html",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim", -- optional
			"neovim/nvim-lspconfig", -- optional
		},
		opts = {
			document_color = {
				enabled = false, -- can be toggled by commands
			},
		},
	},
	{
		"chrisgrieser/nvim-lsp-endhints",
		event = "LspAttach",
		-- enabled = false,
		opts = {
			icons = {
				type = "󰜁  ",
				parameter = "󰏪  ",
				offspec = "  ", -- hint kind not defined in official LSP spec
				unknown = "  ", -- hint kind is nil
			},
			label = {
				padding = 2,
			},
		},
	},
}
