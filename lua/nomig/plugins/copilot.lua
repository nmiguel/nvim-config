return {
	"zbirenbaum/copilot.lua",
	event = "InsertEnter",
	keys = {
		{
			"<leader>ce",
			function()
                vim.cmd("Copilot enable")
                print("Copilot enabled")
            end,
			mode = "n",
			desc = "Enable Copilot",
		},
		{
			"<leader>cd",
			function()
                vim.cmd("Copilot disable")
                print("Copilot disabled")
            end,
			mode = "n",
			desc = "Disable Copilot",
		},
	},
	config = function()
		require("copilot").setup({
			panel = {
				enabled = true,
				auto_refresh = false,
				keymap = {
					jump_prev = "[[",
					jump_next = "]]",
					accept = "<C-O>",
					refresh = "gr",
					open = "<M-CR>",
				},
				layout = {
					position = "bottom", -- | top | left | right
					ratio = 0.4,
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 75,
				keymap = {
					accept = "<C-J>",
					accept_word = false,
					accept_line = false,
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			filetypes = {
				yaml = false,
				markdown = false,
				help = false,
				gitcommit = false,
				gitrebase = false,
				hgcommit = false,
				svn = false,
				cvs = false,
				["."] = false,
			},
			copilot_node_command = "node", -- Node.js version must be > 18.x
			server_opts_overrides = {},
		})

	end,
}
