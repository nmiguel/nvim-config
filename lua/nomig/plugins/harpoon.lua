return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
    lazy = false,
	dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
	config = function()
		local harpoon = require("harpoon")

        local opts = {
            ui_nav_wrap = true
        }
		-- REQUIRED
		harpoon:setup()
		-- REQUIRED


		vim.keymap.set("n", "<leader>h", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():append()
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>f", function()
			harpoon:list():prev(opts)
		end)
		vim.keymap.set("n", "<leader>j", function()
			harpoon:list():next(opts)
		end)
	end,
}
