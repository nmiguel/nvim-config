return {
	{
		"mfussenegger/nvim-dap",
        lazy = true,
		config = function()
			vim.keymap.set("n", "<leader>b", ":DapToggleBreakpoint<CR>")
			vim.keymap.set("n", "<leader>d<space>", ":DapContinue<CR>")
			vim.keymap.set("n", "<leader>dl", ":DapStepInto<CR>")
			vim.keymap.set("n", "<leader>dj", ":DapStepOver<CR>")
			vim.keymap.set("n", "<leader>dh", ":DapStepOut<CR>")
			vim.keymap.set("n", "<leader>dz", ":ZoomWinTabToggle<CR>")
			vim.keymap.set(
				"n",
				"<leader>dgt", -- dg as in debu[g] [t]race
				":lua require('dap').set_log_level('TRACE')<CR>"
			)
			vim.keymap.set(
				"n",
				"<leader>dge", -- dg as in debu[g] [e]dit
				function()
					vim.cmd(":edit " .. vim.fn.stdpath("cache") .. "/dap.log")
				end
			)
			vim.keymap.set("n", "<F1>", ":DapStepOut<CR>")
			vim.keymap.set("n", "<F2>", ":DapStepOver<CR>")
			vim.keymap.set("n", "<F3>", ":DapStepInto<CR>")
			vim.keymap.set("n", "<leader>d-", function()
				require("dap").restart()
			end)
			vim.keymap.set("n", "<leader>d_", function()
				require("dap").terminate()
				require("dapui").close()
			end)
		end,
        event = "VeryLazy",
	},

	-- A default "GUI" front-end for nvim-dap
	{
		"rcarriga/nvim-dap-ui",
        lazy = true,
		config = function()
			require("dapui").setup()

			-- Note: Added this <leader>dd duplicate of <F5> because somehow the <F5>
			-- mapping keeps getting reset each time I restart nvim-dap. Annoying but whatever.
			--
			vim.keymap.set("n", "<leader>dd", function()
				require("dapui").open() -- Requires nvim-dap-ui

				vim.cmd([[DapContinue]]) -- Important: This will lazy-load nvim-dap
			end)

			require("nvim-dap-virtual-text").setup({
				-- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
				only_first_definition = false,
				all_references = true,
				display_callback = function(variable)
					if #variable.value > 15 then
						return "  " .. string.sub(variable.value, 1, 15) .. "... "
					end

					return " " .. variable.value
				end,
			})

			vim.api.nvim_set_hl(0, "NvimDapVirtualText", { bg = "none", fg = "#34ebeb" })
			vim.api.nvim_set_hl(0, "NvimDapVirtualTextError", { bg = "none", fg = "#fc0f0f" })
			vim.api.nvim_set_hl(0, "NvimDapVirtualTextChanged", { bg = "none", fg = "#fc860f" })
		end,
		dependencies = {
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap",
			"theHamsta/nvim-dap-virtual-text",
		},
	},

	-- Remember nvim-dap breakpoints between sessions, ``:PBToggleBreakpoint``
	{
		"Weissle/persistent-breakpoints.nvim",
		config = function()
			require("persistent-breakpoints").setup({
				load_breakpoints_event = { "BufReadPost" },
			})

			vim.keymap.set("n", "<leader>db", ":PBToggleBreakpoint<CR>")
		end,
	},
}
