return {
    "otavioschwanck/arrow.nvim",
    event = "VeryLazy",
    opts = {
        show_icons = true,
        leader_key = '<leader>h' -- Recommended to be a single key
    },
    keys = {
        { mode = "n",
        "<leader>f",
        function()
            require("arrow.persist").previous()
        end,
        desc = "Previous File"
        },

        { mode = "n",
        "<leader>j",
        function()
            require("arrow.persist").next()
        end,
        desc = "Next file"
        },

        { mode = "n",
        "<leader>a",
        function()
            require("arrow.persist").toggle()
        end,
        desc = "Add file to arrow"
        },

    }
}
