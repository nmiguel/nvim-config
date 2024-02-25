vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function(event)
        vim.keymap.set("n", "<leader>rp", ":w<CR>:exec '!python ' . shellescape(expand('%'))<CR>")
    end,
})

