---@diagnostic disable: missing-fields
return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"fredrikaverpil/neotest-golang", -- Installation
            "nvim-neotest/neotest-python",
		},

		keys = {
			{
				"<leader>tt",
				function()
					require("neotest").summary.toggle()
				end,
				mode = "n",
			},
			-- {
			-- 	"<leader>tT",
			-- 	function()
			-- 		require("neotest").run.run(vim.fn.expand("%"))
			--		require("neotest").summary.open()
			-- 	end,
			-- 	mode = "n",
			-- },
		},

		config = function()
			require("neotest").setup({
                status = {
                    signs = false,
                },
				adapters = {
					require("neotest-golang"), -- Registration
                    require("neotest-python"),
				},
			})
		end,
	},
}
