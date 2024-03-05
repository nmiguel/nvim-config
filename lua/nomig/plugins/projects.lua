return {
    "ahmedkhalf/project.nvim",
    config = function()
        require("project_nvim").setup {
            vim.keymap.set('n', '<leader>op', ':Telescope projects<CR>', { noremap = true, silent = true })

        }

        require('telescope').load_extension('projects')
    end
}
