return {
	"brenoprata10/nvim-highlight-colors",
	event = "BufEnter",

	opts = {
		---@usage 'background'|'foreground'|'virtual'
		render = "virtual",

		---Set virtual symbol (requires render to be set to 'virtual')
		virtual_symbol = "",

		---Highlight named colors, e.g. 'green'
		enable_named_colors = true,

		---Set custom colors
		---Label must be properly escaped with '%' to adhere to `string.gmatch`
		--- :help string.gmatch
		custom_colors = {
			{ label = "%-%-theme%-primary%-color", color = "#0f1219" },
			{ label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
		},
	},
}
