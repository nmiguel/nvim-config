return {
    "stevearc/oil.nvim",
    cond = false,
    keys = {
        { mode = "n",
        "<leader>pv",
        "<cmd>Oil --float<cr>"
        },
    },
    config = function()
        require("oil").setup({
        })
    end,
}
