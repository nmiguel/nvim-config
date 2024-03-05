vim.api.nvim_create_augroup("NomigGroup", {
    clear = true
})

vim.api.nvim_create_autocmd({"BufWritePre"}, {
    group = "NomigGroup",
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
