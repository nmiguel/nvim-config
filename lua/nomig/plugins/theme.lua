local opts = {
	lazy = false,
	cond = false,
	priority = 1000,
}

local themes = {
	tokyonight = {
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
	everforest = {
		"neanias/everforest-nvim",
		config = function()
			require("everforest").setup({})
			vim.g.everforest_background = "hard"
			vim.cmd.colorscheme("everforest")
		end,
	},
	catppuccin = {
		"catppuccin/nvim",
		config = function()
			vim.cmd.colorscheme("catppuccin-macchiato")
		end,
	},
	rose_pine = {
		"rose-pine/neovim",
		config = function()
			vim.cmd.colorscheme("rose-pine")
		end,
	},
	kanagawa = {
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
			})
			vim.cmd.colorscheme("kanagawa")
		end,
	},
	gruvbox = {
		"sainnhe/gruvbox-material",
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.gruvbox_material_enable_italic = true
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	nordic = {
		"AlexvZyl/nordic.nvim",
		config = function()
			require("nordic").load()
			vim.cmd.colorscheme("nordic")
		end,
	},
}

themes.kanagawa.cond = true

local theme_spec = {}
for name, _ in pairs(themes) do
	themes[name] = vim.tbl_extend("keep", themes[name], opts)
	themes[name] = vim.tbl_extend("keep", themes[name], { name = name })
	table.insert(theme_spec, themes[name])
end

return theme_spec
