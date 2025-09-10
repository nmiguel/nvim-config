return {
	"folke/persistence.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	lazy = false,
	priority = 1000,

	config = function()
		require("persistence").setup({
			need = 1,
			branch = false,
		})
		-- Auto save session
		vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			callback = function()
				require("persistence").save()
			end,
		})
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				if vim.fn.argc() == 0 then
					vim.schedule(function()
						require("persistence").load()
					end)
				end
			end,
		})
	end,
}
