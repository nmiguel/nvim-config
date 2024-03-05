return {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
        'neovim/nvim-lspconfig',
        'nvim-telescope/telescope.nvim',
        'mfussenegger/nvim-dap-python',
    },
    ft = "python",

    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "python",
            callback = function()
                vim.keymap.set("n", "<leader>rp", ":w<CR>:exec '!python ' . shellescape(expand('%'))<CR>")
                vim.keymap.set("n", '<leader>pe', '<cmd>VenvSelect<cr>')
                vim.keymap.set("n", '<leader>pc', '<cmd>VenvSelectCached<cr>')
            end,
        })

        require('venv-selector').setup {
            --- other configuration
            search = true,
            parents = 1,
        }
    end
}
