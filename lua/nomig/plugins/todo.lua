return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        --TODO: fix the keyword search
        require('todo-comments').setup
        {
            opts = {
                colors = {
                    error = { "DiagnosticError", "ErrorMsg", "#FFFFFF" },
                    warning = { "DiagnosticWarn", "WarningMsg", "#FFFFFF" },
                    info = { "DiagnosticInfo", "#FFFFFF" },
                    hint = { "DiagnosticHint", "#FFFFFF" },
                    default = { "Identifier", "#FFFFFF" },
                    test = { "Identifier", "#FFFFFF" }
                },
                search = {
                    pattern = [[\b(KEYWORDS)\b]],
                },
            }
        }
    end
}
