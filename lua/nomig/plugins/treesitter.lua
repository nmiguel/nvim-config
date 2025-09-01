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
	-- 	branch = "main",
	-- 	event = "BufRead",
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		event = "BufRead",
	-- 	},
	-- 	opts = {
	-- 		multiwindow = true,
	-- 	},
	-- },
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			local ts_textobjects = require("nvim-treesitter-textobjects")

			ts_textobjects.setup({
				select = {
					enable = true,
					lookahead = true,
					include_surrounding_whitespace = true,
					-- Set line select mode
					selection_modes = {
						["@function.inner"] = "V",
						["@class.inner"] = "V",
						["@function.outer"] = "V",
						["@class.outer"] = "V",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
				},
			})

			local select = require("nvim-treesitter-textobjects.select")
			local move = require("nvim-treesitter-textobjects.move")
			local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

			-- SELECT keymaps
			vim.keymap.set({ "x", "o" }, "if", function()
				select.select_textobject("@function.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "af", function()
				select.select_textobject("@function.outer", "textobjects")
			end)

			vim.keymap.set({ "x", "o" }, "iC", function()
				select.select_textobject("@class.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "aC", function()
				select.select_textobject("@class.outer", "textobjects")
			end)

			vim.keymap.set({ "x", "o" }, "ic", function()
				select.select_textobject("@conditional.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ac", function()
				select.select_textobject("@conditional.outer", "textobjects")
			end)

			vim.keymap.set({ "x", "o" }, "is", function()
				select.select_textobject("@block.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "as", function()
				select.select_textobject("@block.outer", "textobjects")
			end)

			-- MOVE keymaps
			vim.keymap.set({ "n", "x", "o" }, "]f", function()
				move.goto_next_start("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]C", function()
				move.goto_next_start("@class.outer", "textobjects")
			end)

			vim.keymap.set({ "n", "x", "o" }, "[f", function()
				move.goto_previous_start("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[C", function()
				move.goto_previous_start("@class.outer", "textobjects")
			end)

			vim.keymap.set({ "n", "x", "o" }, "]c", function()
				move.goto_next("@conditional.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[c", function()
				move.goto_previous("@conditional.outer", "textobjects")
			end)

			-- Repeatable movement (; and ,)
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
		end,
	},
}
