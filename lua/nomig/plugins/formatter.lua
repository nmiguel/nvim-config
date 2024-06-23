return {
	"mhartington/formatter.nvim",
	keys = {
		{
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
				cs = { function ()
                    local csharpier = require("formatter.filetypes.cs").csharpier()
                    return csharpier
                end},
				json = {
					function()
						local jq = require("formatter.filetypes.json").jq()
						jq.args = { "--indent", "4", "." }
						return jq
					end,
				},
				yaml = { require("formatter.filetypes.yaml").prettier },
				zig = { require("formatter.filetypes.zig").zigfmt },
				go = { require("formatter.filetypes.go").gofmt },
				gleam = { function ()
                    local gleam = { exe = "gleam", args = { "format", "--stdin" }, stdin = true }
                    return gleam
                end,},
			},
		})
	end,
}
