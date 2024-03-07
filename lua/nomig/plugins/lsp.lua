return {
    'neovim/nvim-lspconfig',
    -- ft = {
    --     "python",
    --     "lua",
    --     "cs",
    --     "yaml"
    -- },
    dependencies = {
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },

        -- Autocompletion
        { 'folke/neodev.nvim' },
        { 'L3MON4D3/LuaSnip' },
    },

    config = function()
        require("neodev").setup({

        })

        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = {buffer = event.buf}

                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>va", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end
        })

        -- to learn how to use mason.nvim with lsp-zero
        -- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {'pyright', 'csharp_ls'},
            handlers = {
                lua_ls = function()
                    require('lspconfig').lua_ls.setup({

                    })
                end,
                ["pyright"] = function ()
                    local lspconfig = require("lspconfig")
                    lspconfig.pyright.setup({
                        settings = {
                            python = {
                                analysis = {
                                    autoSearchPaths = true,
                                    diagnosticMode = "openFilesOnly",
                                    useLibraryCodeForTypes = true,
                                    typeCheckingMode = "off"
                                }
                            }
                        }
                    })
                end
            }
        })
    end
        -- local cmp = require('cmp')
        -- local cmp_select = {behavior = cmp.SelectBehavior.Select}
        --
        -- -- this is the function that loads the extra snippets to luasnip
        -- -- from rafamadriz/friendly-snippets
        -- -- require('luasnip.loaders.from_vscode').lazy_load()
        --
        -- cmp.setup({
        --     sources = {
        --         {name = 'path'},
        --         {name = 'nvim_lsp'},
        --         {name = 'nvim_lua'},
        --         {name = 'luasnip', keyword_length = 2},
        --         {name = 'buffer', keyword_length = 3},
        --     },
        --     mapping = cmp.mapping.preset.insert({
        --         ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        --         ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        --         ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        --         ['<C-Space>'] = cmp.mapping.complete(),
        --     }),
        --     window = {
        --     },
        -- })
}
