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
		local prettier = {
			require("formatter.filetypes.javascript").prettier,
		}
		require("formatter").setup({
			logging = true,
			log_level = vim.log.levels.DEBUG,
			filetype = {
				markdown = {
					require("formatter.filetypes.markdown").prettier,
				},
				lua = { require("formatter.filetypes.lua").stylua },
				python = {
					function()
						local iruff = require("formatter.filetypes.python").iruff()
						iruff.args = {
							"check",
							"-q",
							"--select",
							"I",
							"--fix",
							-- "-",
						}
						iruff.stdin = false
						return iruff
					end,
					function()
						local ruff = require("formatter.filetypes.python").iruff()
						ruff.args = {
							"format",
							"-q",
							-- "-",
						}
						ruff.stdin = false
						return ruff
					end,
				},
				cs = {
					function()
						local csharpier = require("formatter.filetypes.cs").csharpier
						return csharpier
					end,
				},
				json = {
					function()
						local jq = require("formatter.filetypes.json").jq()
						jq.args = { "--indent", "4", "." }
						return jq
					end,
				},
				yaml = { require("formatter.filetypes.yaml").prettier },
                rust = { require("formatter.filetypes.rust").rustfmt },
				go = {
					-- require("formatter.filetypes.go").goimports,
					require("formatter.filetypes.go").gofmt,
				},
				css = prettier,
				html = require("formatter.filetypes.html").htmlbeautifier,
				htmldjango = prettier,
			},
		})
	end,
}
