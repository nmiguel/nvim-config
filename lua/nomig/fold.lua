vim.opt.foldmethod = "manual"
vim.opt.foldlevel = 20
vim.opt.foldenable = false

function _G.CustomFoldText()
	local start_lnum = vim.v.foldstart
	local end_lnum = vim.v.foldend

	local indent = vim.fn.indent(start_lnum)
	local spacing = string.rep(" ", indent)

	local function first50(line)
		line = line:gsub("^%s*", "")
		if #line > 50 then
			return line:sub(1, 50) .. " ..."
		end
		return line
	end

	local start = first50(vim.fn.getline(start_lnum))
	local finish = first50(vim.fn.getline(end_lnum))

	local line_count = end_lnum - start_lnum + 1

	return string.format("%s%s (%d lines) %s", spacing, start, line_count, finish)
end

vim.opt.foldtext = "v:lua.CustomFoldText()"


-- Materialize only one Tree-sitter level so opening a fold never exposes closed children.
local function fold_level(target)
	local line_count = vim.api.nvim_buf_line_count(0)
	local levels = {}
	local starts = {}

	for line = 1, line_count do
		local expression = vim.treesitter.foldexpr(line)
		levels[line] = tonumber(expression:match("%d+")) or 0

		local level = tonumber(expression:match("^>(%d+)$"))
		if level == target then
			starts[#starts + 1] = line
		end
	end

	local ranges = {}
	for _, first in ipairs(starts) do
		local last = line_count
		for line = first + 1, line_count do
			local next_start = tonumber(vim.treesitter.foldexpr(line):match("^>(%d+)$"))
			if levels[line] < target or (next_start and next_start <= target) then
				last = line - 1
				break
			end
		end
		if last > first then
			ranges[#ranges + 1] = { first, last }
		end
	end

	local view = vim.fn.winsaveview()
	vim.wo.foldmethod = "manual"
	vim.cmd("normal! zE")
	vim.wo.foldenable = true
	for _, range in ipairs(ranges) do
		vim.cmd(("%d,%dfold"):format(range[1], range[2]))
	end
	vim.fn.winrestview(view)
end

for level = 1, 5 do
	vim.keymap.set("n", "z" .. level, function()
		fold_level(level)
	end, { desc = "Fold only level " .. level })
end
