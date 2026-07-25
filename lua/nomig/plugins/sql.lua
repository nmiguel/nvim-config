return {
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_winwidth = 50
			vim.g.db_ui_auto_execute_table_helpers = 1
			vim.g.db_ui_disable_progress_bar = 1

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("DadbodCompletion", { clear = true }),
				pattern = { "sql", "mysql", "plsql" },
				callback = function(event)
					vim.bo[event.buf].omnifunc = "vim_dadbod_completion#omni"
					vim.bo[event.buf].complete = table.concat({
						"Fv:lua.NativeCompletionSnippets",
						"o",
						".",
						"w",
						"b",
					}, ",")
				end,
			})
		end,
	},
}
