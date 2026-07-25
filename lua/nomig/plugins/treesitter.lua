return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		branch = "main",
		commit = "6620ae1c44dfa8623b22d0cbf873a9e8d073b849",
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
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"nix",
				"python",
				"query",
				"regex",
				"rust",
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
			vim.keymap.set("x", "n", function()
				vim.treesitter.select("parent", vim.v.count1)
			end, { noremap = true, silent = true })
			vim.keymap.set("x", "N", function()
				vim.treesitter.select("child", vim.v.count1)
			end, { noremap = true, silent = true })

			local treesitter = require("nvim-treesitter")
			local parser_configs = require("nvim-treesitter.parsers")
			local install_options = { max_jobs = 4 }
			local ensured = {}
			for _, parser in ipairs(opts.ensure_installed or {}) do
				ensured[parser] = true
			end

			local function start(bufnr)
				if not vim.api.nvim_buf_is_valid(bufnr) or not vim.api.nvim_buf_is_loaded(bufnr) then
					return false
				end

				local parser = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
				local highlighter = vim.treesitter.highlighter.active[bufnr]
				if highlighter and highlighter.tree:lang() ~= parser then
					vim.treesitter.stop(bufnr)
					if vim.bo[bufnr].indentexpr == "v:lua.require'nvim-treesitter'.indentexpr()" then
						vim.bo[bufnr].indentexpr = ""
					end
					highlighter = nil
				end

				local started = highlighter ~= nil
				if not started then
					started = pcall(vim.treesitter.start, bufnr, parser)
				end
				if started then
					vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
				return started
			end

			local function start_loaded_buffers()
				for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
					if vim.bo[bufnr].filetype ~= "" then
						start(bufnr)
					end
				end
			end

			if opts.ensure_installed and #opts.ensure_installed > 0 then
				treesitter.install(opts.ensure_installed, install_options):await(function(err, success)
					if err or not success then
						vim.schedule(function()
							vim.notify(
								"Some Tree-sitter parsers failed to install; run :checkhealth nvim-treesitter",
								vim.log.levels.WARN
							)
						end)
					end
					vim.schedule(start_loaded_buffers)
				end)
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
				desc = "Start Treesitter or install a missing parser",
				callback = function(event)
					local filetype = event.match
					if start(event.buf) then
						return
					end

					-- Skip filetypes managed by other plugins (kulala.nvim owns http/rest)
					local plugin_managed = { "http", "rest" }
					if vim.list_contains(plugin_managed, filetype) then
						return
					end

					local parser = vim.treesitter.language.get_lang(filetype)
					if not parser or not parser_configs[parser] or ensured[parser] then
						return
					end

					treesitter.install({ parser }, install_options):await(function(err, success)
						if err or not success then
							vim.schedule(function()
								vim.notify(
									"Failed to install the " .. parser .. " Tree-sitter parser",
									vim.log.levels.WARN
								)
							end)
							return
						end
						vim.schedule(function()
							start(event.buf)
						end)
					end)
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		commit = "93d60a475f0b08a8eceb99255863977d3a25f310",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			local ts_textobjects = require("nvim-treesitter-textobjects")

			ts_textobjects.setup({
				select = {
					enable = true,
					lookahead = true,
					include_surrounding_whitespace = true,
					-- Set line select mode
					selection_modes = function()
						return "V"
					end,
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

			vim.keymap.set({ "x", "o" }, "ib", function()
				select.select_textobject("@block.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ab", function()
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

			vim.keymap.set({ "n", "x", "o" }, "]b", function()
				move.goto_next("@block.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[b", function()
				move.goto_previous("@block.outer", "textobjects")
			end)

			-- Repeatable movement (; and ,)
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
			vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
		end,
	},
}
