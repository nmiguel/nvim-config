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

		-- Use telescope
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end

		vim.keymap.set("n", "<leader>h", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Open harpoon window" })

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
