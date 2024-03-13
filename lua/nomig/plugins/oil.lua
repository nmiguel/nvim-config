return {
    "stevearc/oil.nvim",
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
