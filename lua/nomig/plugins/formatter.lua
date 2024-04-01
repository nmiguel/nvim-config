return {
	"mhartington/formatter.nvim",
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>cf",
			"<cmd>Format<cr>",
			mode = { "n", "x" },
			desc = "Conform File",
		},
	},
	config = function()
		require("formatter").setup({
            logging = true,
            log_level = vim.log.levels.DEBUG,
			filetype = {
				lua = { require("formatter.filetypes.lua").stylua },
				python = { require("formatter.filetypes.python").black },
				cs = { require("formatter.filetypes.cs").csharpier },
				json = { require("formatter.filetypes.json").prettier },
				yaml = { require("formatter.filetypes.yaml").prettier },
			},
		})
	end,
}
