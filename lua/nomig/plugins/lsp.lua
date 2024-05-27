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
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",

		-- Autocompletion
		"folke/neodev.nvim",
		"L3MON4D3/LuaSnip",
		"nvim-telescope/telescope.nvim",
		"Hoffs/omnisharp-extended-lsp.nvim",
		{
			"iabdelkareem/csharp.nvim",
			dependencies = {
				"williamboman/mason.nvim",
				"Tastyep/structlog.nvim",
			},
			config = function()
				require("csharp").setup()
			end,
		},
	},

	config = function()
		vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
		vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
		vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
		vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

		vim.diagnostic.config({
			virtual_text = {
				prefix = "",
			},
		})

		-- vim.lsp.inlay_hint.enable()

		require("neodev").setup({})

		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				local opts = { buffer = event.buf, noremap = true }

				vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, opts)
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
		local _border = "single"

		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = _border,
		})

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = _border,
		})

		-- to learn how to use mason.nvim with lsp-zero
		-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = { "pyright", "gopls", "yamlls", "jsonls", "omnisharp", "zls" },
			handlers = {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({})
				end,
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						on_init = function(client)
							local path = client.workspace_folders[1].name
							if
								vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc")
							then
								return
							end

							client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
								runtime = {
									-- Tell the language server which version of Lua you're using
									-- (most likely LuaJIT in the case of Neovim)
									version = "LuaJIT",
								},
								-- Make the server aware of Neovim runtime files
								workspace = {
									checkThirdParty = false,
									library = {
										vim.env.VIMRUNTIME,
										-- Depending on the usage, you might want to add additional paths here.
										-- "${3rd}/luv/library"
										-- "${3rd}/busted/library",
									},
									-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
									-- library = vim.api.nvim_get_runtime_file("", true)
								},
							})
						end,
						settings = {
							Lua = {
								runtime = { version = "LuaJIT" },
								diagnostics = {
									globals = { "vim", "require" },
								},
								workspace = {
									-- Make the server aware of Neovim runtime files
									library = vim.api.nvim_get_runtime_file("", true),
								},
								-- Do not send telemetry data containing a randomized but unique identifier
								telemetry = {
									enable = false,
								},
							},
						},
					})
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
									-- typeCheckingMode = "off",
								},
							},
						},
					})
				end,
				["omnisharp"] = function()
					local pid = vim.fn.getpid()
					local omnisharp_bin = "/usr/bin/Omnisharp/omnisharp"
					require("lspconfig").omnisharp.setup({
						cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
						on_attach = function(client)
							require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
						end,
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
				["jsonls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.jsonls.setup({
						settings = {},
					})
				end,
				["yamlls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.yamlls.setup({
						settings = {},
					})
				end,
				["zls"] = function()
					vim.g.zig_fmt_autosave = 0
					local lspconfig = require("lspconfig")
					lspconfig.zls.setup({
						settings = {
							zig_exe_path = "/usr/bin/zig/zig",
						},
					})
				end,
			},
		})
	end,
}
