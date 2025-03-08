return {
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-telescope/telescope.nvim",
			"mfussenegger/nvim-dap-python",
		},
		ft = "python",
		lazy = true,
		branch = "regexp",

		keys = {
			{ mode = "n", "<leader>pe", "<cmd>VenvSelect<cr>", desc = "Select venv" },
		},

		config = function()
			local opts = {
				-- search = true,
				-- parents = 1,
			}
			require("venv-selector").setup(opts)
			-- require("venv-selector").retrieve_from_cache()
		end,
	},
	{
		"fredrikaverpil/pydoc.nvim",
		dependencies = {
			{ "folke/snacks.nvim" },
			{
				"nvim-treesitter/nvim-treesitter",
				opts = {
					ensure_installed = { "markdown" },
				},
			},
		},
		cmd = { "PyDoc" },
		opts = {
			picker = {
				type = "snacks",
				snacks = {},
			},
		},
	},

	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		config = function()
			require("dap-python").setup("python3")
		end,
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-treesitter/nvim-treesitter",
		},
	},
}
