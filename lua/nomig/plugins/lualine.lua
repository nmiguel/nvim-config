return {
	"nvim-lualine/lualine.nvim",
	event = "BufEnter",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		{
			"letieu/harpoon-lualine",
            enabled = false,
			dependencies = {
				{
					"ThePrimeagen/harpoon",
					branch = "harpoon2",
				},
			},
		},
	},
	config = function()
		-- Eviline config for lualine
		-- Author: shadmansaleh
		-- Credit: glepnir
		local lualine = require("lualine")

        -- Color table for highlights
        -- stylua: ignore
        local colors = {
            bg       = 'none',
            fg       = '#78acff',
            yellow   = '#ECBE7B',
            cyan     = '#008080',
            dark_blue     = '#425478',
            green    = '#98be65',
            orange   = '#FF8800',
            violet   = '#a9a1e1',
            main_font   = '#cfe1ff',
            blue     = '#1f4e99',
            red      = '#ec5f67',
        }

		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end,
			check_git_workspace = function()
				local filepath = vim.fn.expand("%:p:h")
				local gitdir = vim.fn.finddir(".git", filepath .. ";")
				return gitdir and #gitdir > 0 and #gitdir < #filepath
			end,
		}

		-- Config
		local config = {
			options = {
				-- Disable sections and component separators
				-- component_separators = { left = "", right = "" },
				-- section_separators = { left = "", right = "" },
				section_separators = "",
				component_separators = "",
				theme = {
					-- We are going to use lualine_c an lualine_x as left and
					-- right section. Both are highlighted by c theme .  So we
					-- are just setting default looks o statusline
					normal = { c = { fg = colors.fg, bg = colors.bg } },
					inactive = { c = { fg = colors.fg, bg = colors.bg } },
				},
				globalstatus = true,
			},
			sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
				-- These will be filled later
			},
			inactive_sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
			},
		}

		-- Inserts a component in lualine_c at left section
		local function ins(tab, component)
			table.insert(tab, component)
		end

		ins(config.sections.lualine_c, {
			-- mode component
			function()
				return ""
			end,
			color = function()
				-- auto change color according to neovims mode
				local mode_color = {
					n = colors.red,
					i = colors.green,
					v = colors.blue,
					[""] = colors.blue,
					V = colors.blue,
					c = colors.blue,
					no = colors.red,
					s = colors.orange,
					S = colors.orange,
					ic = colors.yellow,
					R = colors.main_font,
					Rv = colors.main_font,
					cv = colors.red,
					ce = colors.red,
					r = colors.cyan,
					rm = colors.cyan,
					["r?"] = colors.cyan,
					["!"] = colors.red,
					t = colors.red,
				}
				return { fg = mode_color[vim.fn.mode()] }
			end,
			padding = { left = 1, right = 1 },
		})

		ins(config.sections.lualine_c, {
			"filename",
			cond = conditions.buffer_not_empty,
			path = 1,
			newfile_status = true,
			symbols = {
				modified = "  ",
			},
			color = { fg = colors.main_font, gui = "bold" },
		})

		ins(config.sections.lualine_c, {
			"diff",
			-- Is it me or the symbol for modified us really weird
			symbols = { added = " ", modified = " ", removed = " " },
			diff_color = {
				added = { fg = colors.green },
				modified = { fg = colors.fg },
				removed = { fg = colors.red },
			},
			cond = conditions.hide_in_width,
		})

		-- ins_left { 'location' }

		ins(config.sections.lualine_c, {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = { error = " ", warn = " ", info = " " },
			diagnostics_color = {
				color_error = { fg = colors.red },
				color_warn = { fg = colors.yellow },
				color_info = { fg = colors.cyan },
			},
		})

		-- Insert mid section. You can make any number of sections in neovim :)
		-- for lualine it's any number greater then 2
		ins(config.sections.lualine_c, {
			function()
				return "%="
			end,
		})

		ins(config.sections.lualine_x, {
			"grapple",
			color = { fg = colors.dark_blue, gui = "bold" },
		})

		-- ins(config.sections.lualine_x, {
		-- 	"harpoon2",
		-- 	color = { fg = colors.dark_blue, gui = "bold" },
		-- })

		ins(config.sections.lualine_x, {
			-- Lsp server name .
			function()
				local msg = ""
				local buf_ft = vim.bo.filetype
				local clients = vim.lsp.get_active_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return client.name
					end
				end
				return msg
			end,
			icon = " ",
			cond = function()
				local buf_ft = vim.bo.filetype
				local clients = vim.lsp.get_active_clients()
				if next(clients) == nil then
					return false
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return true
					end
				end
				return false
			end,
			color = { fg = colors.main_font, gui = "bold" },
		})

		ins(config.sections.lualine_x, {
			"branch",
			icon = "",
			color = { fg = colors.violet, gui = "bold" },
		})

		-- Now don't forget to initialize lualine
		lualine.setup(config)
	end,
}
