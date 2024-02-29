require("toggleterm").setup{
    open_mapping = [[<c-\>]],
    autochdir = true,
    -- on_open = function(term)
    --     local venv_path = require('venv-selector').get_active_venv()
    --     if venv_path and venv_path ~= "" then
    --         -- Assuming the environment activation script is named 'activate'
    --         -- and located within the 'venv_path' directory.
    --         local activate_command = string.format("call %s/scripts/activate.bat", venv_path)
    --         vim.api.nvim_buf_set_lines(term.bufnr, -1, -1, false, {activate_command})
    --     end
    -- end,
}

vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]])
