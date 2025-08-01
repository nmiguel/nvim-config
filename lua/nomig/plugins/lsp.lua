return {
	{
		"neovim/nvim-lspconfig",

		event = "BufEnter",
		dependencies = {
			"williamboman/mason.nvim",

			"saghen/blink.cmp",
			-- "nvim-telescope/telescope.nvim",
			"folke/snacks.nvim",
			"justinsgithub/wezterm-types",

			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "luvit-meta/library", words = { "vim%.uv" } },
						{ path = "wezterm-types", mods = { "wezterm" } },
						{ path = "snacks.nvim", words = { "Snacks" } },
					},
				},
			},
			{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
		},

		config = function()
			local diagnostic_highlights = {
				[vim.diagnostic.severity.ERROR] = "DiagnosticError",
				[vim.diagnostic.severity.WARN] = "DiagnosticWarn",
				[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
				[vim.diagnostic.severity.HINT] = "DiagnosticHint",
			}

			vim.diagnostic.config({
				severity_sort = true,
				-- virtual_lines = {
				-- 	current_line = true,
				-- },
				underline = {
					severity = { vim.diagnostic.severity.ERROR },
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = "!!",
						[vim.diagnostic.severity.INFO] = "!",
						[vim.diagnostic.severity.HINT] = "?",
					},
					numhl = diagnostic_highlights,
					-- linehl = diagnostic_highlights,
					priority = 10000,
				},
				-- virtual_text = {
				-- 	spacing = 2,
				-- 	prefix = " ",
				-- 	source = "if_many",
				--                 severity = vim.diagnostic.severity.ERROR,
				-- 	format = function(_) -- disable text
				-- 		return ""
				-- 	end,
				-- 	current_line = false,
				-- },
				update_in_insert = false,
			})

			vim.lsp.inlay_hint.enable()

			local group = vim.api.nvim_create_augroup("OoO", {})

			-- Set up diagnostic float window
			local function au(typ, pattern, cmdOrFn)
				if type(cmdOrFn) == "function" then
					vim.api.nvim_create_autocmd(typ, { pattern = pattern, callback = cmdOrFn, group = group })
				else
					vim.api.nvim_create_autocmd(typ, { pattern = pattern, command = cmdOrFn, group = group })
				end
			end

			au({ "CursorHold", "InsertLeave" }, nil, function()
				local opts = {
					focusable = false,
					scope = "cursor",
					border = "rounded",
					close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
				}
				vim.diagnostic.open_float(nil, opts)
			end)

			au("InsertEnter", nil, function()
				vim.diagnostic.enable(false)
			end)

			au("InsertLeave", nil, function()
				vim.diagnostic.enable(true)
			end)

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf, noremap = true }

					vim.keymap.set("n", "gd", require("snacks").picker.lsp_definitions, opts)
					vim.keymap.set("n", "gt", require("snacks").picker.lsp_type_definitions, opts)
					vim.keymap.set("n", "gi", require("snacks").picker.lsp_implementations, opts)
					vim.keymap.set("n", "<leader>vr", require("snacks").picker.lsp_references, opts)
					vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>ds", require("snacks").picker.lsp_symbols, opts)
					vim.keymap.set("n", "<leader>ws", require("snacks").picker.lsp_workspace_symbols, opts)
					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover({ border = "rounded" })
					end, opts)
				end,
			})

			require("mason").setup({})

			-- Set default configuration for all servers
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			vim.lsp.config("*", {
				root_markers = { ".git" },
				capabilities = capabilities,
			})

			local get_lsp = function(dir)
                local lsp_files = {}
				for _, file in ipairs(vim.fn.globpath(dir, "*.lua", false, true)) do
					-- Read the first line of the file
					local f = io.open(file, "r")
					local first_line = f and f:read("*l") or ""
					if f then
						f:close()
					end
					-- Only include the file if it doesn't start with "-- disable"
					if not first_line:match("^%-%- disable") then
						local name = vim.fn.fnamemodify(file, ":t:r") -- `:t` gets filename, `:r` removes extension
						table.insert(lsp_files, name)
					end
				end
                return lsp_files
			end

			vim.lsp.enable(get_lsp(vim.fn.stdpath("config") .. "/lsp/"))
			vim.lsp.enable(get_lsp(vim.fn.stdpath("config") .. "/after/lsp/"))
		end,
	},
}
