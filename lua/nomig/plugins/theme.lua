local opts = {
    lazy = false,
    cond = false,
    priority = 1000,
}

local themes = {
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				transparent = true,
				style = "night",
				dim_inactive = true,
				styles = {
					sidebars = "transparent",
					floats = "transparent",
				},
			})

			vim.cmd.colorscheme("tokyonight")
		end,
	},
	{
		"neanias/everforest-nvim",
		config = function()
			require("everforest").setup({})
			vim.cmd.colorscheme("everforest")
		end,
	},
	{
		"catppuccin/nvim",
        name = "catppuccin",
		config = function()
			vim.cmd.colorscheme("catppuccin-macchiato")
		end,
	},
	{
		"rose-pine/neovim",
        name = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	},
}

for i, theme in ipairs(themes) do
    themes[i] = vim.tbl_extend("keep", theme, opts)
end

themes[3].cond = true

return themes
