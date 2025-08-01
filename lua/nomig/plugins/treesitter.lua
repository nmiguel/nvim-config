return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all" (the five listed parsers should always be installed)
				ensure_installed = {
					"c",
					"lua",
					"python",
					"c_sharp",
					"vim",
					"vimdoc",
					"query",
					"yaml",
					"go",
					"gomod",
					"gowork",
					"gosum",
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,

				-- List of parsers to ignore installing (or "all")
				ignore_install = { "javascript" },

				---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
				-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

				highlight = {
					enable = true,

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = true,
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true,

						keymaps = {
							["if"] = "@function.inner",
							["af"] = "@function.outer",

							["iC"] = "@class.inner",
							["aC"] = "@class.outer",

							["ic"] = "@conditional.inner",
							["ac"] = "@conditional.outer",

							["is"] = "@block.inner",
							["as"] = "@block.outer",
						},
						include_surrounding_whitespace = true,
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]f"] = "@function.outer",
							["]C"] = { query = "@class.outer", desc = "Next class start" },
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[C"] = "@class.outer",
						},
						goto_next = {
							["]c"] = "@conditional.outer",
							["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
						},
						goto_previous = {
							["[c"] = "@conditional.outer",
							["[s"] = { query = "@local.scope", query_group = "locals", desc = "Previous scope" },
						},
					},
				},
			})
		end,
	},
}
