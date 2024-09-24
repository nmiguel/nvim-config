return {
	"michaelrommel/nvim-silicon",
	lazy = true,
	cmd = "Silicon",
	main = "nvim-silicon",
	keys = {
		{
			mode = "v",
			"<leader>sc",
			function()
				require("nvim-silicon").clip()
			end,
			{ noremap = true, silent = true },
		},
	},
	opts = {
		-- Configuration here, or leave empty to use defaults
		line_offset = function(args)
			return args.line1
		end,
		theme = "Nord",
        pad_horiz = 0,
        pad_vert = 0,
        no_round_corner = true,
        background = "#2e3440",
		wslclipboard = "auto",
		language = function()
			return vim.bo.filetype
		end,
		window_title = function()
			return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
		end,
		-- whether to strip of superfluous leading whitespace
		gobble = true,
	},
}
