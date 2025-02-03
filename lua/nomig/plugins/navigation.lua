return {
	"oskarrrrrrr/symbols.nvim",
	-- Optional dependencies
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope.nvim",
	},

	keys = {
		{
			"<leader>lf",
			mode = "n",
			function()
				vim.cmd("SymbolsToggle")
			end,
			desc = "Navigate file",
		},
	},
	config = function()
		local r = require("symbols.recipes")

		-- Define the custom filter function
		local filter_function = function(ft, symbol)
			if ft == "python" then
				local kind = symbol.kind
				if kind == "Variable" or kind == "Constant" then
					return false
				end
				return true
			end
			return r.DefaultFilters.sidebar.symbol_filter(ft, symbol)
		end

		-- Setup symbols with the copied filters
		require("symbols").setup({
			sidebar = {
				hide_cursor = false,
				-- cursor_follow = false,
				symbol_filter = filter_function,
				cursor_follow = true,
				auto_peek = true,
				close_on_goto = true,
			},
			-- preview = {
			-- 	show_always = true,
			-- },
			keymaps = {},
		})
	end,
}
