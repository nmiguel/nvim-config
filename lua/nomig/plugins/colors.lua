function MyTheme(color)
    color = color or 'onedark'
    vim.cmd.colorscheme(color)

    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    require('onedark').setup {
        transparent = true
    }
    vim.cmd('colorscheme onedark')
end

return {
    'navarasu/onedark.nvim',
    lazy = false,
    name = 'my_theme',
    config = function()
        MyTheme()
    end
}
