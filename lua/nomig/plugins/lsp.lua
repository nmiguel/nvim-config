return {
	{
		"neovim/nvim-lspconfig",

		event = "BufEnter",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Autocompletion
			"L3MON4D3/LuaSnip",
			"nvim-telescope/telescope.nvim",

			-- Lua extra config
			{
				{
					"folke/lazydev.nvim",
					ft = "lua", -- only load on lua files
					opts = {
						library = {
							-- See the configuration section for more details
							-- Load luvit types when the `vim.uv` word is found
							{ path = "luvit-meta/library", words = { "vim%.uv" } },
						},
					},
				},
				{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
				{ -- optional completion source for require statements and module annotations
					"hrsh7th/nvim-cmp",
					opts = function(_, opts)
						opts.sources = opts.sources or {}
						table.insert(opts.sources, {
							name = "lazydev",
							group_index = 0, -- set group index to 0 to skip loading LuaLS completions
						})
					end,
				},
			},
		},

		config = function()
			vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
			vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

			vim.diagnostic.config({
				virtual_text = {
					spacing = 4,
					prefix = "",
					source = "if_many",
				},
				update_in_insert = false,
			})

			-- vim.lsp.inlay_hint.enable()

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf, noremap = true }

					vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, opts)
					vim.keymap.set("n", "gt", require("telescope.builtin").lsp_type_definitions, opts)
					vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, opts)
					-- Uses a different plugin
					-- vim.keymap.set("n", "<leader>va", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>vr", require("telescope.builtin").lsp_references, opts)
					-- vim.keymap.set("n", "<leader>vr", vim.lsp.buf., opts)
					vim.keymap.set("n", "<leader>vn", vim.lsp.buf.rename, opts)
					vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, opts)
					vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, opts)
				end,
			})

			local _border = "single"
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = _border,
			})
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = _border,
			})

			require("mason").setup({
				ensure_installed = { "pyright", "gopls", "yamlls", "jsonls", "zls" },
			})
			require("mason-lspconfig").setup({})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						workspace = {
							checkThirdParty = false,
						},
						codeLens = {
							enable = true,
						},
						completion = {
							callSnippet = "Replace",
						},
						doc = {
							privateName = { "^_" },
						},
						hint = {
							enable = true,
							setType = false,
							paramType = true,
							paramName = "Disable",
							semicolon = "Disable",
							arrayIndex = "Disable",
						},
					},
				},
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "openFilesOnly",
							useLibraryCodeForTypes = true,
							typeCheckingMode = "off",
							exclude = { "venv" },
						},
					},
				},
			})
			lspconfig.gopls.setup({
				capabilities = capabilities,
				settings = {
					gopls = {
						gofumpt = true,
						codelenses = {
							gc_details = false,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						analyses = {
							fieldalignment = true,
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
						},
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
						directoryFilters = {
							"-.git",
							"-.vscode",
							"-.idea",
							"-.vscode-test",
							"-node_modules",
						},
						semanticTokens = true,
					},
				},
			})
			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})
			lspconfig.yamlls.setup({
				capabilities = capabilities,
			})
		end,
	},
	{
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		event = "LspAttach",
		config = function()
			require("tiny-code-action").setup()
			vim.api.nvim_set_keymap(
				"n",
				"<leader>va",
				"<cmd>lua require('tiny-code-action').code_action()<cr>",
				{ noremap = true, silent = true }
			)
		end,
	},
	{
		"kosayoda/nvim-lightbulb",
		event = "LspAttach",
		config = function()
			vim.api.nvim_set_hl(0, "LightBulbSign", { fg = "#FFA500", bg = "none" })
			require("nvim-lightbulb").setup({
				autocmd = { enabled = true },
				sign = {
					enabled = true,
					-- Text to show in the sign column.
					-- Must be between 1-2 characters.
					text = "",
					-- Highlight group to highlight the sign column text.
					hl = "LightBulbSign",
				},
			})
		end,
	},
	{
		-- Notifies to state of the LSP server
		"j-hui/fidget.nvim",
		enabled = false,
		opts = {
			-- options
			notification = {
				window = {
					winblend = 0,
				},
			},
		},
	},
}
