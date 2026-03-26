local opts = {
	lazy = false,
	cond = false,
	priority = 1000,
}

local themes = {
	{
		"folke/tokyonight.nvim",
        name = "tokyonight",
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
        name = "everforest",
		config = function()
			require("everforest").setup({})
			vim.g.everforest_background = "hard"
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
	{
		"rebelot/kanagawa.nvim",
        name = "kanagawa",
		config = function()
			vim.cmd.colorscheme("kanagawa")
		end,
	},
	{
		"sainnhe/gruvbox-material",
        name = "gruvbox",
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.gruvbox_material_enable_italic = true
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
}

for i, theme in ipairs(themes) do
	themes[i] = vim.tbl_extend("keep", theme, opts)
end

themes[3].cond = true

return themes
