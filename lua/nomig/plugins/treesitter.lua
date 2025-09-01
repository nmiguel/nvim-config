return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		branch = "main",
		opts = {
			-- custom handling of parsers
			ensure_installed = {
				"astro",
				"bash",
				"c",
				"css",
				"diff",
				"go",
				"gomod",
				"gowork",
				"gosum",
				"graphql",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"json5",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
				"ruby",
			},
		},
		config = function(_, opts)
			-- install parsers from custom opts.ensure_installed
			if opts.ensure_installed and #opts.ensure_installed > 0 then
				require("nvim-treesitter").install(opts.ensure_installed)
				-- register and start parsers for filetypes
				for _, parser in ipairs(opts.ensure_installed) do
					local filetypes = parser -- In this case, parser is the filetype/language name
					vim.treesitter.language.register(parser, filetypes)
				end
			end

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(ctx)
					local bufnr = ctx.buf
					-- highlights
					local hasStarted = pcall(vim.treesitter.start, bufnr) -- errors for filetypes with no parser
					-- vim.bo[bufnr].syntax = "on"

					-- indent
					local noIndent = {}
					if hasStarted and not vim.list_contains(noIndent, ctx.match) then
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})

			-- Auto-install and start parsers for any buffer
			vim.api.nvim_create_autocmd({ "BufRead" }, {
				callback = function(event)
					local bufnr = event.buf
					local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

					-- Skip if no filetype
					if filetype == "" then
						return
					end

					-- Check if this filetype is already handled by explicit opts.ensure_installed config
					for _, filetypes in pairs(opts.ensure_installed) do
						local ft_table = type(filetypes) == "table" and filetypes or { filetypes }
						if vim.tbl_contains(ft_table, filetype) then
							return -- Already handled above
						end
					end

					-- Get parser name based on filetype
					local parser_name = vim.treesitter.language.get_lang(filetype) -- might return filetype (not helpful)
					if not parser_name then
						return
					end
					-- Try to get existing parser (helpful check if filetype was returned above)
					local parser_configs = require("nvim-treesitter.parsers")
					if not parser_configs[parser_name] then
						return -- Parser not available, skip silently
					end

					local parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

					if not parser_installed then
						-- If not installed, install parser synchronously
						require("nvim-treesitter").install({ parser_name }):wait(30000)
					end

					-- let's check again
					parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

					if parser_installed then
						-- Start treesitter for this buffer
						vim.treesitter.start(bufnr, parser_name)
					end
				end,
			})
		end,
	},
	-- {
	-- 	"nvim-treesitter/nvim-treesitter-context",
	-- 	event = "BufRead",
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		event = "BufRead",
	-- 	},
	-- 	opts = {
	-- 		multiwindow = true,
	-- 	},
	-- },
	-- {
	-- 	"nvim-treesitter/nvim-treesitter-textobjects",
	-- 	branch = "main",
	-- 	dependencies = "nvim-treesitter/nvim-treesitter",
	-- 	config = function()
	-- 		require("nvim-treesitter.config").setup({
	-- 			textobjects = {
	-- 				select = {
	-- 					enable = true,
	-- 					lookahead = true,
	--
	-- 					keymaps = {
	-- 						["if"] = "@function.inner",
	-- 						["af"] = "@function.outer",
	--
	-- 						["iC"] = "@class.inner",
	-- 						["aC"] = "@class.outer",
	--
	-- 						["ic"] = "@conditional.inner",
	-- 						["ac"] = "@conditional.outer",
	--
	-- 						["is"] = "@block.inner",
	-- 						["as"] = "@block.outer",
	-- 					},
	-- 					include_surrounding_whitespace = true,
	-- 				},
	-- 				move = {
	-- 					enable = true,
	-- 					set_jumps = true, -- whether to set jumps in the jumplist
	-- 					goto_next_start = {
	-- 						["]f"] = "@function.outer",
	-- 						["]C"] = { query = "@class.outer", desc = "Next class start" },
	-- 					},
	-- 					goto_previous_start = {
	-- 						["[f"] = "@function.outer",
	-- 						["[C"] = "@class.outer",
	-- 					},
	-- 					goto_next = {
	-- 						["]c"] = "@conditional.outer",
	-- 						["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
	-- 					},
	-- 					goto_previous = {
	-- 						["[c"] = "@conditional.outer",
	-- 						["[s"] = { query = "@local.scope", query_group = "locals", desc = "Previous scope" },
	-- 					},
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
