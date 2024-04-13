return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
        "nvim-lua/plenary.nvim",
        "Myzel394/jsonfly.nvim",
    },
    lazy = false,
	config = function()
		local builtin = require("telescope.builtin")
		-- local telescope = require('telescope')
		-- telescope.setup({
		--     pickers = {
		--         hidden = true
		--     }
		-- })
		vim.keymap.set("n", "<leader>pf", builtin.find_files)
		vim.keymap.set("n", "<leader>paf", function()
			builtin.find_files({ no_ignore = true })
		end)
		vim.keymap.set("n", "<leader>ps", builtin.live_grep)
		vim.keymap.set("n", "<leader>ds", builtin.help_tags)
	end,
}
