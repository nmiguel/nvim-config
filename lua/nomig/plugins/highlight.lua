return {
	{
		"nvim-mini/mini.hipatterns",
		config = function()
			local hipatterns = require("mini.hipatterns")

			-- round-robin groups
			local rr_groups = {
				"CustomHighlight1",
				"CustomHighlight2",
				"CustomHighlight3",
				"CustomHighlight4",
			}

			-- cycle index
			local rr_index = 1
			local function next_group()
				local g = rr_groups[rr_index]
				rr_index = rr_index % #rr_groups + 1
				return g
			end

			-- user-created pattern → group
			local user_patterns = {}

			-- create built-in highlights
			hipatterns.setup({
				highlighters = {
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
					debugprint = { pattern = "DEBUGPRINT", group = "DebugPrintLine" },
					hex_color = hipatterns.gen_highlighter.hex_color({
						style = "inline",
						inline_text = " ",
					}),
				},
			})

			-- helper: register new pattern
			local function add_user_pattern(pattern)
				local group = next_group()
				hipatterns.config.highlighters[pattern] = { pattern = pattern, group = group }
				user_patterns[pattern] = group
			end

			-- helper: remove pattern
			local function remove_user_pattern(pattern)
				hipatterns.config.highlighters[pattern] = nil
				user_patterns[pattern] = nil
			end

			-- helper: clear all
			local function clear_all_user_patterns()
				for pat, _ in pairs(user_patterns) do
					hipatterns.config.highlighters[pat] = nil
				end
				user_patterns = {}
			end

			vim.api.nvim_create_user_command("Highlight", function(args)
				local pattern = args.fargs[1]
				if user_patterns[pattern] then
					remove_user_pattern(pattern)
				else
					add_user_pattern(pattern)
				end
				hipatterns.toggle()
				hipatterns.toggle()
			end, { nargs = 1 })

			vim.api.nvim_create_user_command("ClearHighlights", function()
				clear_all_user_patterns()
				hipatterns.toggle()
				hipatterns.toggle()
			end, {})
		end,
	},
}
