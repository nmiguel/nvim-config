return {
    { 'stevearc/dressing.nvim' },
    { 'tpope/vim-fugitive' },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
    { 'kana/vim-textobj-entire',
        dependencies = { 'kana/vim-textobj-user' }
    },
    { 'tpope/vim-surround' },

}
