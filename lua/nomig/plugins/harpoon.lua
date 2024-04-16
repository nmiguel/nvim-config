return {
	"kimabrandt-flx/harpoon",
	-- branch = "kimabrandt-flx:feat_sync_selection",
    commit = "5bdbb379d949f7a48c08decb10250debe0a0d398",
    lazy = false,
	dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup()
		-- REQUIRED


		vim.keymap.set("n", "<leader>h", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>f", function()
			harpoon:list():prev({
            ui_nav_wrap = true
        })
		end)
		vim.keymap.set("n", "<leader>j", function()
			harpoon:list():next({
            ui_nav_wrap = true
        })
		end)
	end,
}
