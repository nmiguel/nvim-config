return {
	"xzbdmw/colorful-menu.nvim",
	lazy = false,
	dependencies = { { "L3MON4D3/LuaSnip", version = "v2.*" } },

	config = function()
		local colorful_menu = require("colorful-menu")

		local kind_names = {
			[1] = "Text",
			[2] = "Method",
			[3] = "Function",
			[4] = "Constructor",
			[5] = "Field",
			[6] = "Variable",
			[7] = "Class",
			[8] = "Interface",
			[9] = "Module",
			[10] = "Property",
			[11] = "Unit",
			[12] = "Value",
			[13] = "Enum",
			[14] = "Keyword",
			[15] = "Snippet",
			[16] = "Color",
			[17] = "File",
			[18] = "Reference",
			[19] = "Folder",
			[20] = "EnumMember",
			[21] = "Constant",
			[22] = "Struct",
			[23] = "Event",
			[24] = "Operator",
			[25] = "TypeParameter",
		}

		-- These are Blink's default "normal" Nerd Font icons.
		local kind_icons = {
			Text = "󰉿",
			Method = "󰊕",
			Function = "󰊕",
			Constructor = "󰒓",
			Field = "󰜢",
			Variable = "󰆦",
			Property = "󰖷",
			Class = "󱡠",
			Interface = "󱡠",
			Struct = "󱡠",
			Module = "󰅩",
			Unit = "󰪚",
			Value = "󰦨",
			Enum = "󰦨",
			EnumMember = "󰦨",
			Keyword = "󰻾",
			Constant = "󰏿",
			Snippet = "󱄽",
			Color = "󰏘",
			File = "󰈔",
			Reference = "󰬲",
			Folder = "󰉋",
			Event = "󱐋",
			Operator = "󰪚",
			TypeParameter = "󰬛",
		}

		local function completion_start(pattern)
			local cursor = vim.api.nvim_win_get_cursor(0)
			local line_to_cursor = vim.api.nvim_get_current_line():sub(1, cursor[2])
			return vim.fn.match(line_to_cursor, pattern)
		end

		_G.NativeCompletionPaths = function(findstart, base)
			if findstart == 1 then
				return completion_start([[\f*$]])
			end
			if base == "" then
				return {}
			end

			return vim.tbl_map(function(path)
				local is_directory = vim.fn.isdirectory(vim.fn.expand(path)) == 1
				return {
					word = path,
					abbr = path,
					kind = kind_icons[is_directory and "Folder" or "File"],
					user_data = { custom_completion = "path" },
				}
			end, vim.fn.getcompletion(base, "file"))
		end

		_G.NativeCompletionSnippets = function(findstart, _)
			if findstart == 1 then
				return completion_start([[\k*$]])
			end

			local luasnip = require("luasnip")
			local cursor = vim.api.nvim_win_get_cursor(0)
			local line_to_cursor = vim.api.nvim_get_current_line():sub(1, cursor[2])
			local snippets = {}

			for _, filetype in ipairs(luasnip.get_snippet_filetypes()) do
				local available = vim.list_extend(
					vim.list_slice(luasnip.get_snippets(filetype, { type = "snippets" })),
					luasnip.get_snippets(filetype, { type = "autosnippets" })
				)

				for _, snippet in ipairs(available) do
					local shown = not snippet.hidden
					if shown and snippet.show_condition then
						local ok, result = pcall(snippet.show_condition, line_to_cursor)
						shown = ok and result
					end

					if shown then
						local doc = snippet:get_docstring()
						table.insert(snippets, {
							word = snippet.trigger,
							abbr = snippet.regTrig and snippet.name or snippet.trigger,
							kind = kind_icons.Snippet,
							info = type(doc) == "table" and table.concat(doc, "\n") or doc,
							user_data = {
								custom_completion = "luasnip",
								priority = snippet.effective_priority or 0,
								snippet_id = snippet.id,
							},
							priority = snippet.effective_priority or 0,
						})
					end
				end
			end

			table.sort(snippets, function(a, b)
				if a.priority == b.priority then
					return a.word < b.word
				end
				return a.priority > b.priority
			end)
			for _, snippet in ipairs(snippets) do
				snippet.priority = nil
			end

			return { words = snippets, refresh = "always" }
		end

		vim.opt.complete = {
			"o",
			"Fv:lua.NativeCompletionPaths",
			"Fv:lua.NativeCompletionSnippets",
			".",
		}

		vim.opt.completeopt = { "menu", "menuone", "popup", "fuzzy", "noinsert", "nosort" }

		vim.opt.completeitemalign = { "kind", "abbr", "menu" }
		vim.opt.pumborder = "rounded"
		vim.opt.pumheight = 12

		vim.o.autocomplete = true
		vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
			desc = "Disable native completion in picker input buffers",
			callback = function(event)
				vim.bo[event.buf].autocomplete = vim.bo[event.buf].filetype ~= "snacks_picker_input"
			end,
		})

		local completion_group = vim.api.nvim_create_augroup("NativeCompletion", { clear = true })
		local source_order = { lsp = 1, path = 2, luasnip = 3, buffer = 4 }

		local function completion_source(item)
			local data = type(item.user_data) == "table" and item.user_data or {}
			if vim.tbl_get(data, "nvim", "lsp") then
				return "lsp", data
			end
			return data.custom_completion or "buffer", data
		end

		local function compare_completion_sources(a, b)
			local a_source, a_data = completion_source(a)
			local b_source, b_data = completion_source(b)
			if a_source ~= b_source then
				return source_order[a_source] < source_order[b_source]
			end

			if a_source == "lsp" then
				local a_item = vim.tbl_get(a_data, "nvim", "lsp", "completion_item") or {}
				local b_item = vim.tbl_get(b_data, "nvim", "lsp", "completion_item") or {}
				local a_sort = a_item.sortText or a_item.label or a.word or ""
				local b_sort = b_item.sortText or b_item.label or b.word or ""
				if a_sort ~= b_sort then
					return a_sort < b_sort
				end
			elseif a_source == "luasnip" and a_data.priority ~= b_data.priority then
				return (a_data.priority or 0) > (b_data.priority or 0)
			end

			return (a.word or a.abbr or "") < (b.word or b.abbr or "")
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = completion_group,
			desc = "Enable native LSP completion",
			callback = function(event)
                vim.cmd("setlocal complete=o")
				local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
				if not client:supports_method("textDocument/completion") then
					return
				end

				vim.lsp.completion.enable(true, client.id, event.buf, {
					cmp = compare_completion_sources,
					convert = function(item)
						local kind_name = kind_names[item.kind] or "Text"
						local highlights = colorful_menu.highlights(item, client.name)
						local first_highlight = highlights and highlights.highlights and highlights.highlights[1]
						local highlight_group = first_highlight and (first_highlight.hl_group or first_highlight[1])

						return {
							abbr = highlights and highlights.text or item.label,
							abbr_hlgroup = highlight_group,
							kind = kind_icons[kind_name],
							kind_hlgroup = vim.fn.hlexists("CmpItemKind" .. kind_name) == 1
									and ("CmpItemKind" .. kind_name)
								or nil,
							menu = "",
						}
					end,
				})
			end,
		})

		local timer = vim.uv.new_timer()
		local delay = 200
		local function callback(ev)
			local node = vim.treesitter.get_node()

			-- check if we are in the arguments of a function
			if not node or node:type() ~= "arguments" or node:parent():type() ~= "function_call" then
				return
			end

			-- debounce
			timer:start(delay, 0, function()
				timer:stop()
				vim.schedule(function()
					-- since this function will run later, the buffer
					-- may be unloaded or changed to another
					local buf = vim.api.nvim_get_current_buf()
					if not vim.api.nvim_buf_is_valid(ev.buf) or ev.buf ~= buf then
						return
					end

					-- we do not want completion menu
					-- and signature opened together
					if vim.fn.pumvisible() == 0 then
						vim.lsp.buf.signature_help({ focusable = false })
					end
				end)
			end)
		end

		vim.api.nvim_create_augroup("lsp_attach.auto_signatute", {})
		vim.api.nvim_create_autocmd("LspAttach", {
			group = "lsp_attach.auto_signatute",
			callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if client and client:supports_method("textDocument/signatureHelp", ev.buf) then
					vim.api.nvim_create_autocmd("CursorMovedI", {
						buffer = ev.buf,
						callback = callback,
					})
				end
			end,
		})

		local preview_request = 0
		vim.api.nvim_create_autocmd("CompleteChanged", {
			group = completion_group,
			desc = "Add a rounded border to completion documentation",
			callback = function(event)
				preview_request = preview_request + 1
				local request = preview_request
				local attempts = 0

				local function add_border()
					if request ~= preview_request or vim.api.nvim_get_current_buf() ~= event.buf then
						return
					end

					for _, winid in ipairs(vim.api.nvim_list_wins()) do
						local config = vim.api.nvim_win_get_config(winid)
						local bufnr = vim.api.nvim_win_get_buf(winid)
						if
							config.relative == "editor"
							and config.anchor == "NW"
							and config.focusable == false
							and config.mouse == true
							and config.style == "minimal"
							and config.zindex == 50
							and not config.hide
							and vim.bo[bufnr].buftype == "nofile"
						then
							vim.api.nvim_win_set_config(winid, { border = "rounded" })
						end
					end

					attempts = attempts + 1
					if attempts < 40 then
						vim.defer_fn(add_border, 50)
					end
				end

				add_border()
			end,
		})

		local function jump_snippet(direction)
			if vim.snippet.active({ direction = direction }) then
				vim.snippet.jump(direction)
				return true
			end

			local luasnip = require("luasnip")
			if luasnip.locally_jumpable(direction) then
				return luasnip.jump(direction)
			end
			return false
		end

		local function map_snippet_jump(lhs, direction, desc)
			vim.keymap.set({ "i", "s" }, lhs, function()
				if not jump_snippet(direction) then
					vim.api.nvim_feedkeys(vim.keycode(lhs), "int", false)
				end
			end, { desc = desc })
		end

		map_snippet_jump("<Tab>", 1, "Jump to next snippet stop")
		map_snippet_jump("<S-Tab>", -1, "Jump to previous snippet stop")
	end,
}
