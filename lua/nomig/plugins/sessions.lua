return {
	"folke/persistence.nvim",
	lazy = false,
	priority = 1000,

	config = function()
		require("persistence").setup({
			need = 1,
			branch = false,
		})

        local group = vim.api.nvim_create_augroup("session_manager", { clear = true })
        -- Detect stdin
		vim.api.nvim_create_autocmd({ "StdinReadPre" }, {
			group = group,
			callback = function()
				vim.g.started_with_stdin = true
			end,
		})

        -- Auto Save
		vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			group = group,
			callback = function()
				require("persistence").save()
			end,
		})

        -- Auto load
		vim.api.nvim_create_autocmd("VimEnter", {
			group = group,
			callback = function()
				if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
					vim.schedule(function()
						require("persistence").load()
					end)
				end
			end,
		})
	end,
}
