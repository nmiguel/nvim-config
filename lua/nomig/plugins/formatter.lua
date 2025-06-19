return {
	"stevearc/conform.nvim",
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ lsp_format = "fallback" })
			end,
			mode = { "n", "v" },
			desc = "Conform File",
		},
	},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				markdown = { "prettier" },
                javascript = { "prettier", "eslint_d" },
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
				html = { "htmlbeautifier" },
				htmldjango = { "prettier" },
			},
		})
	end,
}
