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
					accept_word = "<C-l>",
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

        -- Prevent Copilot from attaching to quickfix buffers
        -- This is the source of errors from sending Snacks to QF List
		local function detach_copilot_from_qf(bufnr)
			vim.schedule(function()
				if not vim.api.nvim_buf_is_valid(bufnr) then
					return
				end

				if vim.bo[bufnr].buftype ~= "quickfix" and vim.bo[bufnr].filetype ~= "qf" then
					return
				end

				pcall(require("copilot.client").buf_detach_if_attached, bufnr)

				local ok, util = pcall(require, "copilot.util")
				if ok then
					util.set_buffer_attach_status(bufnr, util.ATTACH_STATUS_MANUALLY_DETACHED)
				end
			end)
		end

		vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufWinEnter", "LspAttach" }, {
			group = vim.api.nvim_create_augroup("copilot_no_quickfix", { clear = true }),
			callback = function(args)
				detach_copilot_from_qf(args.buf)
			end,
		})
	end,
}
