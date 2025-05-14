return {
	"mrjones2014/smart-splits.nvim",
    lazy = false,  -- needs to always be loaded

	config = function()
		-- resize window
		-- vim.keymap.set("n", "<leader><leader>r", require("smart-splits").start_resize_mode)
		-- moving between splits
		vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
		vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
		vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
		vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
		-- swapping buffers between windows
		vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
		vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
		vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
		vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)

		require("smart-splits").setup({
			ignored_buftypes = {
				"nofile",
				"quickfix",
				"prompt",
			},
			ignored_filetypes = { "NvimTree" },
			default_amount = 7,
			at_edge = 'split', -- Changed this to 'split' to create a new split at the edge
			move_cursor_same_row = false,
			cursor_follows_swapped_bufs = false,
			resize_mode = {
				quit_key = "<ESC>",
				resize_keys = { "h", "j", "k", "l" },
				silent = false,
				hooks = {
					on_enter = nil,
					on_leave = nil,
				},
			},
			ignored_events = {
				"BufEnter",
				"WinEnter",
			},
			multiplexer_integration = false, -- Automatically integrates with Wezterm
			disable_multiplexer_nav_when_zoomed = false,
			kitty_password = nil,
			log_level = "info",
		})
	end,
}
