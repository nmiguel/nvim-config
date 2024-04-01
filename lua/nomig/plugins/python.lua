return {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
        'neovim/nvim-lspconfig',
        'nvim-telescope/telescope.nvim',
        'mfussenegger/nvim-dap-python',
    },
    ft = "python",

    keys = {
        { mode = "n",
        "<leader>rp",
        ":w<CR>:exec '!python ' . shellescape(expand('%'))<CR>",
        desc = "Run python file",
        },

        { mode = "n",
        '<leader>pe',
        '<cmd>VenvSelect<cr>',
        desc = "Select venv",
        },

        { mode = "n",
        '<leader>pc',
        '<cmd>VenvSelectCached<cr>',
        desc = "Select cached venv",
        },

    },

    config = function()
        local opts = {
            search = true,
            parents = 1,
        }
        require('venv-selector').setup(opts)
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "python",
            desc = 'Auto select virtualenv Nvim open',
            callback = function()
                -- local venv = vim.fn.findfile('pyproject.toml', vim.fn.getcwd() .. ';')
                -- if venv ~= '' then
                require('venv-selector').retrieve_from_cache()
                vim.api.nvim_command("silent LspRestart")
                -- end
            end,
            once = true,
        })

    end,
}
