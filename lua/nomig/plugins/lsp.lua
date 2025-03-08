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
				[vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
				[vim.diagnostic.severity.WARN] = "DiagnosticLineWarn",
				[vim.diagnostic.severity.INFO] = "DiagnosticLineInfo",
				[vim.diagnostic.severity.HINT] = "DiagnosticLineHint",
			}

			vim.diagnostic.config({
				virtual_lines = {
					current_line = true,
				},
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
				-- virtual_text = {
				-- 	spacing = 4,
				-- 	prefix = "",
				-- 	source = "if_many",
				-- 	current_line = false,
				-- },
				update_in_insert = false,
			})

			vim.lsp.inlay_hint.enable()

			local _border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf, noremap = true }

					vim.keymap.set("n", "gd", require("snacks").picker.lsp_definitions, opts)
					vim.keymap.set("n", "gt", require("snacks").picker.lsp_type_definitions, opts)
					vim.keymap.set("n", "gi", require("snacks").picker.lsp_implementations, opts)
					vim.keymap.set("n", "<leader>va", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>vr", require("snacks").picker.lsp_references, opts)
					vim.keymap.set("n", "<leader>vn", vim.lsp.buf.rename, opts)
					vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>ds", require("snacks").picker.lsp_symbols, opts)
					vim.keymap.set("n", "<leader>ws", require("snacks").picker.lsp_workspace_symbols, opts)
					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover({ border = _border })
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

            -- require("nomig.plugins.lsp_servers")
		end,
	},
}
