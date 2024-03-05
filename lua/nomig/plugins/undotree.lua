return {
    'mbbill/undotree',
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    keys = {
        {
            "<leader>u",
            function() vim.cmd.UndotreeToggle() end,
            mode = "n",
            desc = "Undo tree",
        }
    }
}
