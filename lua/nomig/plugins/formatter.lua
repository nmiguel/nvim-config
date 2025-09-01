return {
	"stevearc/conform.nvim",
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ lsp_format = "fallback", timeout_ms= 5000, async = true})
			end,
			mode = { "n", "v" },
			desc = "Conform File",
		},
	},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				markdown = { "prettier" },
				javascript = { "prettier" },
				lua = { "stylua" },
				python = {
					"ruff_format",
					"ruff_organize_imports",
				},
				json = {
					"jq",
				},
				yaml = { "prettier" },
				rust = { "rustfmt" },
				go = { "gofumpt" },
				http = {
					{
						command = "kulala-fmt",
						args = { "format" },
						stdin = false,
					},
				},
				css = { "prettier" },
				html = { "prettier" },
				htmldjango = { "djlint" },
			},
		})
	end,
}
