return {
    "folke/trouble.nvim",
    -- branch = "dev", -- IMPORTANT!
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        focus = true,
        win = {
            type = "split",
            position = "right",
            size = 60,
        },
    },
    keys = {
        { "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace Diagnostics (Trouble)" },
        { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document Diagnostics (Trouble)" },
        { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
        -- {
        --     "[d",
        --     function()
        --         if require("trouble").is_open() then
        --             require("trouble").previous({ skip_groups = true, jump = true })
        --         else
        --             local ok, err = pcall(vim.cmd.cprev)
        --             if not ok then
        --                 vim.notify(err, vim.log.levels.ERROR)
        --             end
        --         end
        --     end,
        --     desc = "Previous trouble/quickfix item",
        -- },
        -- {
        --     "]d",
        --     function()
        --         if require("trouble").is_open() then
        --             require("trouble").next({ skip_groups = true, jump = true })
        --         else
        --             local ok, err = pcall(vim.cmd.cnext)
        --             if not ok then
        --                 vim.notify(err, vim.log.levels.ERROR)
        --             end
        --         end
        --     end,
        --     desc = "Next trouble/quickfix item",
        -- },
    },
}
