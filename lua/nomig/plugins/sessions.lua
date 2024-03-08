return {
    "Shatur/neovim-session-manager",
    dependencies = 'nvim-lua/plenary.nvim',
    lazy = false,

    keys = {
        {
            "<leader>ls",
            function() require("session_manager").load_session(true) end,
            mode = "n",
            desc = "Load session"
        }
    },

    opts = {
        sessions_dir = vim.fn.expand("$HOME/sessions"),
        autosave_ignore_buftypes = {}, -- All buffers of these bufer types will be closed before the session is saved.
        autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
        max_path_length = 80,  -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
    },

    config = function()
        -- Auto save session
        vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
            callback = function ()
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                    -- Don't save while there's any 'nofile' buffer open.
                    if vim.api.nvim_get_option_value("buftype", { buf = buf }) == 'nofile' then
                        return
                    end
                end
                require("session_manager").save_current_session()
            end
        })
    end
}

