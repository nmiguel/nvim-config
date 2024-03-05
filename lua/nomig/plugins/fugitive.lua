return {
    'tpope/vim-fugitive' ,
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    keys = {
        {
            "<leader>gs",
            function()
                vim.cmd.Git()
            end,
            mode = "",
            desc = "Git",
        },
    },
}
