return {
	"cenk1cenk2/jq.nvim",
	ft = "json",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"grapp-dev/nui-components.nvim",
	},
    keys = {
        {
            mode = "n",
            "<leader>pj",
            function ()
                require("jq").run()
            end,
            { noremap = true, silent = true },
        },
    },
    config = function ()
        require("jq").setup({})
    end,
}
