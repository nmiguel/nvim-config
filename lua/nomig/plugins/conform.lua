return {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>cf",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            -- Conform will run multiple formatters sequentially
            python = { "isort", "black" },
            cs = { "csharpier" },
        },
        -- format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
}
