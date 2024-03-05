return {
    'stevearc/dressing.nvim',
    'tpope/vim-fugitive',
    'tpope/vim-surround',

    {
        'numToStr/Comment.nvim',
        events = { "BufWritePost", "BufReadPost", "InsertLeave" },
        config = function()
            require('Comment').setup()
        end
    },

    {
        'kana/vim-textobj-entire',
        dependencies = { 'kana/vim-textobj-user' },
        events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    },
}
