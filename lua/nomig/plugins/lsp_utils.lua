return {
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup({
				options = {
					show_source = true,
					show_all_diags_on_cursorline = true,
				},
                transparent_bg = true,
				hi = {
					error = "DiagnosticError", -- Highlight for error diagnostics
					warn = "DiagnosticWarn", -- Highlight for warning diagnostics
					info = "DiagnosticInfo", -- Highlight for info diagnostics
					hint = "DiagnosticHint", -- Highlight for hint diagnostics
					arrow = "NonText", -- Highlight for the arrow pointing to diagnostic
					background = "CursorLine", -- Background highlight for diagnostics
					mixing_color = "None", -- Color to blend background with (or "None")
				},

				-- transparent_bg = true,
				signs = {
					left = "",
					right = " │",
					diag = "●",
					arrow = "",
					up_arrow = "    ",
					vertical = " │",
					vertical_end = " │",
				},
				blend = {
					factor = 0.15,
				},
			})
			vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
		end,
	},
	{
		"Davidyz/inlayhint-filler.nvim",
		enabled = true,
		keys = {
			{
				"<leader>vi",
				function()
					require("inlayhint-filler").fill()
				end,
				desc = "Insert the inlay-hint under cursor into the buffer.",
				mode = { "n", "v" },
			},
		},
	},
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
