return {
	"github/copilot.vim",
	event = "InsertEnter",
	keys = {
		{
			"<leader>ce",
			"<cmd>Copilot enable<CR>",
			mode = "n",
			desc = "Enable Copilot",
		},
		{
			"<leader>cd",
			"<cmd>Copilot disable<CR>",
			mode = "n",
			desc = "Disable Copilot",
		},
	},
	config = function()
		vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
			expr = true,
			replace_keycodes = false,
		})
		vim.g.copilot_no_tab_map = true
	end,
}
