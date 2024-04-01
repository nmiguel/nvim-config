return {
    'stevearc/dressing.nvim',

    {
        'tpope/vim-surround',
        event = { "BufWritePost", "BufReadPost", "InsertEnter" },
    },

    {
        'numToStr/Comment.nvim',
        event = { "BufWritePost", "BufReadPost", "InsertEnter" },
        config = function()
            require('Comment').setup()
        end
    },

    {
        'kana/vim-textobj-entire',
        event = { "VeryLazy" },
        dependencies = { 'kana/vim-textobj-user' },
    },
}
