local function fix_size(str, size)
	if string.len(str) < size then
		str = str .. string.rep(" ", size - string.len(str))
	elseif string.len(str) > size then
		str = string.sub(str, 1, size - 3) .. "..."
	end
	return str
end

return {
	"kdheepak/lazygit.nvim",

	-- optional for floating window border decoration
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"FabijanZulj/blame.nvim",
			keys = {
				{
					"<leader>b",
					"<cmd>BlameToggle<CR>",
					mode = "n",
					desc = "Toggle Blame",
				},
			},
			config = function()
				require("blame").setup({
					colors = {
						"#29c4d6",
						"#98c379",
						"#c678dd",
						"#e86671",
						"#d19a66",
					},
					format_fn = function(line_porcelain, config, idx)
						local hash = string.sub(line_porcelain.hash, 0, 7)
						local line_with_hl = {}
						local is_commited = hash ~= "0000000"
						local summary
						if #line_porcelain.summary > config.max_summary_width then
							summary = string.sub(line_porcelain.summary, 0, config.max_summary_width - 3) .. "..."
						else
							summary = line_porcelain.summary
						end
						return {
							idx = idx,
							values = {
								{
									textValue = os.date(config.date_format, line_porcelain.committer_time),
									hl = "Comment",
								},
								{
									textValue = fix_size(line_porcelain.author, 15),
									hl = hash,
								},
								{
									textValue = summary,
									hl = "@text",
								},
							},
							format = "%s  %s  %s",
						}
					end,
				})
			end,
		},
	},

	keys = {
		{ "<leader>gs", mode = "n", "<cmd>LazyGit<cr>" },
	},
}
