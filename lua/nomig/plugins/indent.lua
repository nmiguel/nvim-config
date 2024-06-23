return {
	-- {
	-- 	"echasnovski/mini.indentscope",
	-- 	version = "*",
	-- 	enabled = false,
	-- 	opts = {
	-- 		draw = {
	-- 			delay = 0,
	-- 			animation = function()
	-- 				return 0
	-- 			end,
	-- 		},
	-- 		symbol = "│",
	-- 	},
	-- },
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("ibl").setup({
				scope = { enabled = true, highlight = "WinSeparator" },
			})
		end,
	},
}
