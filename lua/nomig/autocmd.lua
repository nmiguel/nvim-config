local group = vim.api.nvim_create_augroup("nomig-autocmds", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Remove trailing whitespace on save",
	group = group,
	callback = function()
		local view = vim.fn.winsaveview()
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.winrestview(view)
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = group,
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Disable automatic comment insertion",
	group = group,
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})

