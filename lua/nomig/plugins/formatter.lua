return {
	"mhartington/formatter.nvim",
	event = { "VeryLazy" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>cf",
			"<cmd>FormatWrite<cr>",
			mode = "n",
			desc = "Conform File",
		},
	},
	config = function()
		require("formatter").setup({
			filetype = {
				lua = { require("formatter.filetypes.lua").stylua },
				python = { require("formatter.filetypes.python").black },
				cs = { require("formatter.filetypes.cs").chsarpier },
				["*"] = {
					require("formatter.defaults").prettier,
				},
			},
			-- format_on_save = { timeout_ms = 500, lsp_fallback = true },
		})
	end,
}
