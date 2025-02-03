return {
	{
		"neovim/nvim-lspconfig",

		event = "BufEnter",
		dependencies = {
			"williamboman/mason.nvim",

			"saghen/blink.cmp",
			"nvim-telescope/telescope.nvim",
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
				[vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
				[vim.diagnostic.severity.WARN] = "DiagnosticLineWarn",
				[vim.diagnostic.severity.INFO] = "DiagnosticLineInfo",
				[vim.diagnostic.severity.HINT] = "DiagnosticLineHint",
			}
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
					numhl = diagnostic_highlights,
					linehl = diagnostic_highlights,
					priority = 10, -- Default priority; adjust if needed
				},
				virtual_text = {
					spacing = 4,
					prefix = "",
					source = "if_many",
				},
				update_in_insert = false,
			})

			vim.lsp.inlay_hint.enable()

			local _border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf, noremap = true }

					vim.keymap.set("n", "gd", function()
						Snacks.picker.lsp_definitions()
					end, opts)

					vim.keymap.set("n", "gt", function()
						Snacks.picker.lsp_type_definitions()
					end, opts)

					vim.keymap.set("n", "gi", function()
						Snacks.picker.lsp_implementations()
					end, opts)

					vim.keymap.set("n", "<leader>va", vim.lsp.buf.code_action, opts)

					vim.keymap.set("n", "<leader>vr", function()
						Snacks.picker.lsp_references()
					end, opts)

					vim.keymap.set("n", "<leader>vn", vim.lsp.buf.rename, opts)

					vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)

					vim.keymap.set("n", "<leader>ds", function()
						-- Snacks doc symbols
						Snacks.picker.lsp_symbols()
					end, opts)

					vim.keymap.set("n", "<leader>ws", function()
						-- Snacks workspace symbols
						Snacks.picker.lsp_symbols({ workspace = true })
					end, opts)

					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover({ border = _border })
					end, opts)
				end,
			})

			require("mason").setup({})

			local util = require("lspconfig/util")
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = require("nomig.plugins.lsp.lua_ls"),
				},
			})
			local ruff_capabilities = vim.tbl_deep_extend("force", {}, capabilities)
			ruff_capabilities.hoverProvider = false -- Ruff LSP only provides hover for rules
			lspconfig.ruff.setup({
				init_options = {
					settings = {
						fixAll = false,
						organizeImports = false,
						configurationPreference = "editorOnly",
						lint = {
							ignore = { "E741" },
						},
					},
				},
				capabilities = ruff_capabilities,
			})
			lspconfig.basedpyright.setup({
				capabilities = capabilities,
				filetypes = { "python" },
				root_dir = function(fname)
					return util.root_pattern(
						"pyrightconfig.json",
						"pyproject.toml",
						"Pipfile",
						"setup.py",
						"setup.cfg",
						".git"
					)(fname) or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
				end,
				settings = require("nomig.plugins.lsp.basedpyright"),
			})
			lspconfig.gopls.setup({
				capabilities = capabilities,
				settings = require("nomig.plugins.lsp.gopls"),
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})
			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})
			lspconfig.yamlls.setup({
				capabilities = capabilities,
			})
		end,
	},
}
