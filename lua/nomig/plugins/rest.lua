return {
	"lima1909/resty.nvim",
	ft = "http",
    lazy = true,
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		vim.api.nvim_set_hl(0, "ActiveWin", { underline = true, bold = true })
		vim.api.nvim_set_hl(0, "StatusOK", { fg = "grey" })
		vim.api.nvim_set_hl(0, "StatusNotOK", { fg = "red" })
	end,
}
