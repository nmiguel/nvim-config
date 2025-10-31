return {
	"zbirenbaum/copilot.lua",
	dependencies = {
		-- "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
	},
	cmd = "Copilot",
	event = "InsertEnter",
    keys = {
        { "<leader>ce", desc = "Enable Copilot" },
        { "<leader>cd", desc = "Disable Copilot" },
    },
	config = function()
		require("copilot").setup({
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = "<C-j>",
				},
			},
		})
		vim.keymap.set("n", "<leader>ce", function()
			vim.cmd("silent Copilot enable")
            print("Copilot enabled")
		end, { desc = "Enable Copilot" })
		vim.keymap.set("n", "<leader>cd", function()
            vim.cmd("silent Copilot disable")
            print("Copilot disabled")
		end, { desc = "Disable Copilot" })
	end,
}
