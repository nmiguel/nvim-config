return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		dependencies = {
			"igorlfs/nvim-dap-view",
			opts = {},
		},
		config = function()
			vim.keymap.set("n", "<leader>b", ":DapToggleBreakpoint<CR>")
			vim.keymap.set("n", "<leader>dd", ":DapViewOpen<CR>")
			vim.keymap.set("n", "<leader>d<space>", ":DapContinue<CR>")
			vim.keymap.set("n", "<leader>dl", ":DapStepInto<CR>")
			vim.keymap.set("n", "<leader>dj", ":DapStepOver<CR>")
			vim.keymap.set("n", "<leader>dh", ":DapStepOut<CR>")
			vim.keymap.set("n", "<F1>", ":DapStepOut<CR>")
			vim.keymap.set("n", "<F2>", ":DapStepOver<CR>")
			vim.keymap.set("n", "<F3>", ":DapStepInto<CR>")
			vim.keymap.set("n", "<leader>d-", function()
				require("dap").restart()
			end)
			vim.keymap.set("n", "<leader>d_", function()
				require("dap").terminate()
				require("dap-view").close()
			end)
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

			-- Open dap view automatically
			local dap = require("dap")
			dap.listeners.before.attach.dapui_config = function()
				vim.cmd("DapViewOpen")
			end
			dap.listeners.before.launch.dapui_config = function()
				vim.cmd("DapViewOpen")
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				vim.cmd("DapViewClose")
			end
			dap.listeners.before.event_exited.dapui_config = function()
				vim.cmd("DapViewClose")
			end
		end,
		event = "VeryLazy",
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
