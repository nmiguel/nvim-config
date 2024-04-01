return {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
    },
    opts = function()
        vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

        local cmp = require("cmp")
        local defaults = require("cmp.config.default")()
        return {
            completion = { completeopt = "menu,menuone,noinsert", },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                -- { name = "path" },
            }, {
                { name = "buffer" },
            }),
            formatting = {
                format = function(_, item)
                    local icons = {
                        Array         = " ",
                        Boolean       = "󰨙 ",
                        Class         = " ",
                        Codeium       = "󰘦 ",
                        Color         = " ",
                        Control       = " ",
                        Collapsed     = " ",
                        Constant      = "󰏿 ",
                        Constructor   = " ",
                        Copilot       = " ",
                        Enum          = " ",
                        EnumMember    = " ",
                        Event         = " ",
                        Field         = " ",
                        File          = " ",
                        Folder        = " ",
                        Function      = "󰊕 ",
                        Interface     = " ",
                        Key           = " ",
                        Keyword       = " ",
                        Method        = "󰊕 ",
                        Module        = " ",
                        Namespace     = "󰦮 ",
                        Null          = " ",
                        Number        = "󰎠 ",
                        Object        = " ",
                        Operator      = " ",
                        Package       = " ",
                        Property      = " ",
                        Reference     = " ",
                        Snippet       = " ",
                        String        = " ",
                        Struct        = "󰆼 ",
                        TabNine       = "󰏚 ",
                        Text          = " ",
                        TypeParameter = " ",
                        Unit          = " ",
                        Value         = " ",
                        Variable      = "󰀫 ",
                    }
                    if icons[item.kind] then
                        item.kind = icons[item.kind] .. item.kind
                    end
                    return item
                end,
            },
            experimental = {
                ghost_text = {
                    hl_group = "CmpGhostText",
                },
            },
            sorting = defaults.sorting,
        }
    end,
    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
        for _, source in ipairs(opts.sources) do
            source.group_index = source.group_index or 1
        end
        require("cmp").setup(opts)
    end,
}
