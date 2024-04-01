return {
	"neovim/nvim-lspconfig",
	-- ft = {
	--     "python",
	--     "lua",
	--     "cs",
	--     "yaml"
	-- },

	event = "BufEnter",
	dependencies = {
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },

		-- Autocompletion
		{ "folke/neodev.nvim" },
		{ "L3MON4D3/LuaSnip" },
		{ "nvim-telescope/telescope.nvim" },
	},

	config = function()
		vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
		vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
		vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
		vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
		require("neodev").setup({})

		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				local opts = { buffer = event.buf, noremap = true }

				vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, opts)
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover()
				end, opts)
				vim.keymap.set("n", "<leader>va", function()
					vim.lsp.buf.code_action()
				end, opts)
				vim.keymap.set("n", "<leader>vr", require("telescope.builtin").lsp_references, opts)
				vim.keymap.set("n", "<leader>vn", function()
					vim.lsp.buf.rename()
				end, opts)
				vim.keymap.set("i", "<C-s>", function()
					vim.lsp.buf.signature_help()
				end, opts)
				vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, opts)
				vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, opts)
			end,
		})

		-- to learn how to use mason.nvim with lsp-zero
		-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = { "pyright", "omnisharp" },
			handlers = {
				lua_ls = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({})
				end,
				["pyright"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.pyright.setup({
						settings = {
							python = {
								analysis = {
									autoSearchPaths = true,
									diagnosticMode = "openFilesOnly",
									useLibraryCodeForTypes = true,
									typeCheckingMode = "off",
								},
							},
						},
					})
				end,
				["omnisharp"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.omnisharp.setup({
						settings = {},
					})
				end,
				["gopls"] = function()
					vim.api.nvim_create_autocmd("FileType", {
						pattern = "go",
						desc = "Set go run key",
						callback = function()
							vim.keymap.set("n", "<leader>rp", ":w<CR>:exec '!go run ' . shellescape(expand('%'))<CR>")
						end,
						once = true,
					})
					local lspconfig = require("lspconfig")
					lspconfig.gopls.setup({})
				end,
			},
		})
	end,
}
