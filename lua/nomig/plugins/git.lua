return {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    keys = {
        { "<leader>gs",
        mode = "n",
        "<cmd>LazyGit<cr>" }
    }

    -- 'tpope/vim-fugitive' ,
    -- event = { "BufWritePost", "BufReadPost", "InsertLeave" },
    -- keys = {
    --     {
    --         "<leader>gs",
    --         function()
    --             vim.cmd.Git()
    --         end,
    --         mode = "",
    --         desc = "Git",
    --     },
    -- },
}
