return {
	"stevearc/aerial.nvim",
	-- Optional dependencies
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope.nvim",
		{ "cuducos/yaml.nvim", ft = "yaml" },
	},

	keys = {
		{
			"<leader>lf",
			mode = "n",
			function()
				local type = vim.bo.filetype
				if type == "yaml" then
					require("telescope.builtin").lsp_document_symbols()
				else
					vim.cmd("AerialToggle")
				end
			end,
			desc = "Navigate file",
		},
	},
	opts = {
		backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
		layout = {
			default_direction = "left",
			min_width = 20,
		},
		close_automatic_events = { "unfocus" },
		close_on_select = true,
		autojump = true,
		filter_kind = {
			["_"] = {
				"Class",
				"Constructor",
				"Enum",
				"Function",
				"Interface",
				"Module",
				"Method",
				"Struct",
			},
			yaml = { "Key" },
		},
	},
}
