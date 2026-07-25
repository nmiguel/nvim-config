local kind_icons = {
	[1] = "󰉿",
	[2] = "󰊕",
	[3] = "󰊕",
	[4] = "󰒓",
	[5] = "󰜢",
	[6] = "󰆦",
	[7] = "󱡠",
	[8] = "󱡠",
	[9] = "󰅩",
	[10] = "󰖷",
	[11] = "󰪚",
	[12] = "󰦨",
	[13] = "󰦨",
	[14] = "󰻾",
	[15] = "󱄽",
	[16] = "󰏘",
	[17] = "󰈔",
	[18] = "󰬲",
	[19] = "󰉋",
	[20] = "󰦨",
	[21] = "󰏿",
	[22] = "󱡠",
	[23] = "󱐋",
	[24] = "󰪚",
	[25] = "󰬛",
}

local function completion_start(pattern)
	local cursor = vim.api.nvim_win_get_cursor(0)
	local line_to_cursor = vim.api.nvim_get_current_line():sub(1, cursor[2])
	return vim.fn.match(line_to_cursor, pattern)
end

_G.NativeCompletionPaths = function(findstart, base)
	if findstart == 1 then
		return completion_start([=[\f*$]=])
	end
	if base == "" then
		return {}
	end

	return vim.tbl_map(function(path)
		local is_directory = vim.fn.isdirectory(vim.fn.expand(path)) == 1
		return {
			word = path,
			abbr = path,
			kind = kind_icons[is_directory and 19 or 17],
		}
	end, vim.fn.getcompletion(base, "file"))
end

-- Autocomplete collects sources in this order. Keeping fuzzy sorting disabled
-- preserves LSP results ahead of path and buffer fallbacks.
vim.opt.complete = {
	"o",
	"Fv:lua.NativeCompletionPaths",
	".",
}
vim.opt.completeopt = { "menu", "menuone", "popup", "fuzzy", "noinsert", "nosort" }
vim.opt.completeitemalign = { "kind", "abbr", "menu" }
vim.opt.pumborder = "rounded"
vim.opt.pumheight = 12
vim.o.autocomplete = true
vim.o.autocompletedelay = 100

local completion_group = vim.api.nvim_create_augroup("NativeCompletion", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = completion_group,
	pattern = "snacks_picker_input",
	desc = "Disable native completion in picker input buffers",
	callback = function(event)
		vim.bo[event.buf].autocomplete = false
	end,
})

local function compare_lsp_items(a, b)
	local a_data = type(a.user_data) == "table" and a.user_data or {}
	local b_data = type(b.user_data) == "table" and b.user_data or {}
	local a_item = vim.tbl_get(a_data, "nvim", "lsp", "completion_item") or {}
	local b_item = vim.tbl_get(b_data, "nvim", "lsp", "completion_item") or {}
	local a_sort = a_item.sortText or a_item.label or a.word or ""
	local b_sort = b_item.sortText or b_item.label or b.word or ""

	if a_sort ~= b_sort then
		return a_sort < b_sort
	end
	return (a.word or a.abbr or "") < (b.word or b.abbr or "")
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = completion_group,
	desc = "Enable native LSP completion",
	callback = function(event)
		local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
		if not client:supports_method("textDocument/completion") then
			return
		end

		vim.lsp.completion.enable(true, client.id, event.buf, {
			cmp = compare_lsp_items,
			convert = function(item)
				return { kind = kind_icons[item.kind] }
			end,
		})
	end,
})

local function map_snippet_jump(lhs, direction, desc)
	vim.keymap.set({ "i", "s" }, lhs, function()
		if vim.snippet.active({ direction = direction }) then
			vim.snippet.jump(direction)
		else
			vim.api.nvim_feedkeys(vim.keycode(lhs), "int", false)
		end
	end, { desc = desc })
end

map_snippet_jump("<Tab>", 1, "Jump to next snippet stop")
map_snippet_jump("<S-Tab>", -1, "Jump to previous snippet stop")
