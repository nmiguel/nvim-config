return {
    "ahmedkhalf/project.nvim",
    keys = {
        {
            '<leader>op',
            mode = 'n',
            '<cmd>Telescope projects<CR>',
            desc = "Open Projects"
        }
    },
    config = function()
        require('telescope').load_extension('projects')
    end
}
