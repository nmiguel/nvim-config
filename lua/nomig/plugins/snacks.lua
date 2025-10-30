---@diagnostic disable: undefined-global
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		local hl = "WinSeparator"
		require("snacks").setup({
			styles = {},
			scroll = {
				enabled = false,
			},
			words = { enabled = true },
			notifier = { enabled = false },
			quickfile = { enabled = false },
			-- bigfile = { enabled = true },
			statuscolumn = { enabled = true },

			scope = {
				cursor = false,
				siblings = true,
			},

			indent = {
				only_current = true,
				filter = function()
					local whitelist = { "lua", "python", "go", "json", "rust", "zig", "yaml" }
					local found = false
					for _, k in ipairs(whitelist) do
						if vim.bo.ft == k then
							found = true
						end
					end
					return found
				end,
				enabled = true,
				animate = { enabled = false },
				scope = { enabled = false, hl = hl },
				chunk = {
					enabled = true,
					only_current = true,
					hl = hl,
					char = {
						corner_top = "╭",
						corner_bottom = "╰",
						arrow = "",
					},
				},
			},

			picker = {
				layout = "telescope",
				matcher = {
					fuzzy = true,
					smartcase = true,
					ignorecase = false,
					frecency = true,
					-- sort_empty = true,
				},
				formatters = {
					file = {
						filename_first = true,
						git_status_hl = true,
					},
				},
				win = {
					input = {
						keys = {
							["<Esc>"] = { "close", mode = { "n", "i" } },
							["<C-up>"] = { "toggle_hidden", mode = { "i", "n" } },
							["<C-down>"] = { "toggle_ignored", mode = { "i", "n" } },
						},
					},
				},
				-- toggles = {
				-- 	follow = "",
				-- 	hidden = "",
				-- 	ignored = "",
				-- 	modified = "",
				-- 	regex = { icon = "R", value = false },
				-- },
			},
		})
		vim.api.nvim_create_user_command("Github", function()
			Snacks.gitbrowse()
		end, {})
	end,
	keys = {
		-- Pickers
		{
			mode = "n",
			"<leader>pt",
			function()
				Snacks.explorer()
			end,
		},
		{
			mode = "n",
			"<leader>PP",
			function()
				Snacks.picker()
			end,
		},
		{
			mode = "n",
			"<leader>pm",
			function()
				Snacks.picker.marks({})
			end,
		},
		{
			mode = "n",
			"<leader>paf",
			function()
				Snacks.picker.smart({
					multi = {
						"buffers",
						"recent",
						{
							finder = "files",
							format = "file",
							show_empty = true,
							hidden = true,
							ignored = true,
							follow = false,
							supports_live = true,
						},
					},
				})
			end,
		},
		{
			mode = "n",
			"<leader>pf",
			function()
				Snacks.picker.files({
					finder = "files",
					format = "file",
					show_empty = true,
					-- hidden = true,
					-- ignored = true,
					follow = false,
				})
				-- Snacks.picker.smart({
				-- 	format = "file",
				-- 	matcher = {
				-- 		cwd_bonus = true,
				-- 		frecency = true,
				-- 		sort_empty = true,
				-- 	},
				-- 	transform = "unique_file",
				-- 	multi = {
				-- 		"buffers",
				-- 		"recent",
				-- 		{
				-- 			finder = "files",
				-- 			format = "file",
				-- 			show_empty = true,
				-- 			hidden = true,
				-- 			ignored = false,
				-- 			follow = false,
				-- 			supports_live = true,
				-- 		},
				-- 	},
				-- })
			end,
		},
		{
			mode = "n",
			"<leader>lf",
			function()
				Snacks.picker.lsp_symbols({
					layout = "default",
				})
			end,
		},
		{
			mode = "n",
			"<leader>ps",
			function()
				Snacks.picker.grep()
			end,
		},
		{
			mode = "n",
			"<leader>:",
			function()
				Snacks.picker.commands()
			end,
		},
		{
			mode = { "v", "n" },
			"<leader>*",
			function()
				Snacks.picker.grep_word()
			end,
		},
		-- Other functions
		{
			"<leader>xx",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Diagnostics in current buffer",
		},
		{
			"<leader>xX",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>gf",
			function()
				Snacks.lazygit.log_file()
			end,
			desc = "Lazygit log file",
		},
		{
			"<leader>gs",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
	},
}
