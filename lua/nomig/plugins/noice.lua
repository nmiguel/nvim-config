return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        lsp = {
            progress = { enabled = false },
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },
        },
        views = {
            cmdline_popup = {
                position = {
                    row = "90%",
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = "auto",
                },
            },
            popupmenu = {
                relative = "editor",
                position = {
                    row = "80%",
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = 10,
                },
                border = {
                    style = "rounded",
                    padding = { 0, 1 },
                },
                win_options = {
                    winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                },
            },
        },
    },
    -- stylua: ignore
    keys = {
        { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
        -- { "<leader>snl", function() require("noice").cmd("last") end,                   desc = "Noice Last Message" },
        -- { "<leader>sna", function() require("noice").cmd("all") end,                    desc = "Noice All" },
        -- {
        --     "<c-f>",
        --     function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
        --     silent = true,
        --     expr = true,
        --     desc = "Scroll forward",
        --     mode = { "i",
        --     "n",
        --     "s" }
        -- },
        -- {
        --     "<c-b>",
        --     function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
        --     silent = true,
        --     expr = true,
        --     desc = "Scroll backward",
        --     mode = { "i",
        --     "n",
        --     "s" }
        -- },

    },
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        {
            "rcarriga/nvim-notify",
            opts = {
                on_open = function() end,
                on_close = function() end,
                max_width = 200,
                max_height = 200,
                background_colour = "#000000",
                fps = 160,
                icons = {
                    DEBUG = "",
                    ERROR = "",
                    INFO = "",
                    TRACE = "✎",
                    WARN = ""
                },
                level = 2,
                minimum_width = 50,
                render = "default",
                stages = "fade_in_slide_out",
                time_formats = {
                    notification = "%T",
                    notification_history = "%FT%T"
                },
                timeout = 5000,
                top_down = true
            }
        }
    }
}
