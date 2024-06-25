return {
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-telescope/telescope.nvim",
			"mfussenegger/nvim-dap-python",
		},
		ft = "python",
		branch = "regexp",

		keys = {
			-- {
			-- 	mode = "n",
			-- 	"<leader>rp",
			-- 	":w<CR>:exec '!python ' . shellescape(expand('%'))<CR>",
			-- 	desc = "Run python file",
			-- },

			{ mode = "n", "<leader>pe", "<cmd>VenvSelect<cr>", desc = "Select venv" },

			{
				mode = "n",
				"<leader>pc",
				"<cmd>VenvSelectCached<cr>",
				desc = "Select cached venv",
			},
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
		"mfussenegger/nvim-dap-python",
		config = function()
			require("dap-python").setup("python")
			-- An example configuration to launch any Python file, via Houdini
			-- table.insert(
			--     require("dap").configurations.python,
			--     {
			--         type = "python",
			--         request = "launch",
			--         name = "Launch Via hython",
			--         program = "${file}",
			--         python = "/opt/hfs19.5.569/bin/hython"
			--         -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
			--     }
			-- )
		end,
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-treesitter/nvim-treesitter",
		},
	},
}
