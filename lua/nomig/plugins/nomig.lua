return {
	{
		dir = "~/projects/personal/bastion",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local bastion = require("bastion")

			bastion:setup({
				default = {
					preload_lists = {
						python = { "!pytest", "!python %" },
						lua = { "so", "luafile %" },
						go = { "!go build", "!go run ." },
					},
				},
			})

			vim.keymap.set("n", "<leader>cc", function()
				bastion.ui:toggle_quick_menu(bastion:list())
			end)

			-- vim.keymap.set("n", "<leader>cp", function()
			--              print('Preloaded commands')
			-- 	bastion:list():preload()
			-- end)
		end,
	},
}
