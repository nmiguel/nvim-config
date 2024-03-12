return {
    'mbbill/undotree',
    events = "VeryLazy",
    keys = {
        {
            "<leader>u",
            function() vim.cmd.UndotreeToggle() end,
            mode = "n",
            desc = "Undo tree",
        }
    }
}
