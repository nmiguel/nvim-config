vim.cmd("packadd nvim.undotree")

vim.keymap.set("n", "<leader>u", ":Undotree<CR>", { desc = "Toggle undotree" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "nvim-undotree",
	callback = function()
		vim.cmd.wincmd("H")
		vim.api.nvim_win_set_width(0, 45)
	end,
})

return {}
