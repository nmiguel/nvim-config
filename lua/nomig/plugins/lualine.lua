return {
	"nvim-lualine/lualine.nvim",
	event = "BufEnter",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
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
            is_not_term = function()
                return string.find(vim.api.nvim_buf_get_name(0), "^term://") == nil
            end,
		}

		-- Config
		local config = {
			options = {
				-- Disable sections and component separators
                section_separators = "",
				component_separators = "",
				theme = {
					normal = {
                        a = { fg = colors.fg, bg = colors.bg },
                        b = { fg = colors.fg, bg = colors.bg },
                        c = { fg = colors.fg, bg = colors.bg },
                        x = { fg = colors.fg, bg = colors.bg },
                        y = { fg = colors.fg, bg = colors.bg },
                        z = { fg = colors.fg, bg = colors.bg },
                    },
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
		}

		-- Inserts a component in lualine_c at left section
		local function ins(tab, component)
			table.insert(tab, component)
		end

		ins(config.sections.lualine_a, {
			-- mode component
			function()
				return "ᓚᘏᗢ"
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
				return { fg = mode_color[vim.fn.mode()], gui = "bold"}
			end,
            -- separator = { left = '' }
		})

		ins(config.sections.lualine_b, {
			"filename",
			-- cond = conditions.buffer_not_empty,
            cond = function() return (conditions.buffer_not_empty() and conditions.is_not_term()) end,
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
            draw_empty = true,
			-- cond = conditions.hide_in_width,
		})

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
		ins(config.sections.lualine_x, {
			function()
				return "%="
			end,
		})

		ins(config.sections.lualine_x, {
			"grapple",
			color = { fg = colors.dark_blue, gui = "bold" },
		})

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
