return {
    'stevearc/aerial.nvim',
    -- Optional dependencies
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
        'nvim-telescope/telescope.nvim',
    },

    keys = {
        {
            "<leader>lf",
            mode = "n",
            "<cmd>AerialToggle<cr>",
            desc = "Navigate file"
        }
    },
    opts = {
        backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
        layout = {
            default_direction = "left",
            min_width = 20,
        },
        close_automatic_events = { "unfocus" },
        close_on_select = true,
        autojump = true,
        -- filter_kind = {
        --     ["_"] = {
        --         "Class",
        --         "Constructor",
        --         "Enum",
        --         "Function",
        --         "Interface",
        --         "Module",
        --         "Method",
        --         "Struct",
        --     },
        --     ["yaml"] = { "Key" },
        -- },
        -- filter_kind = false,
        -- on_attach = function(bufnr)
        --     -- Jump forwards/backwards with '{' and '}'
        --     vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        --     vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        -- end,

    },
    -- config = function()
    --     require("telescope").setup({
    --         extensions = {
    --             aerial = {
    --                 -- Display symbols as <root>.<parent>.<symbol>
    --                 show_nesting = {
    --                     ["_"] = false, -- This key will be the default
    --                     json = true,   -- You can set the option for specific filetypes
    --                     yaml = true,
    --                 },
    --             },
    --         },
    --     })
    -- end
}
