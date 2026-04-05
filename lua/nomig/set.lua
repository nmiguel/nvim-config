vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.opt.smartindent = true
vim.opt.hidden = true

vim.opt.showtabline = 0

vim.opt.swapfile = false
vim.opt.fillchars = { eob = " ", fold = " " }
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.shortmess:append("sI")

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 30
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.g.mapleader = " "

vim.o.winborder = "rounded"

-- Use ripgrep
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"

vim.opt.showmode = false

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

-- Disable deprecation warnings
---@diagnostic disable-next-line: duplicate-set-field
vim.deprecate = function() end

vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = require("vim.ui.clipboard.osc52").paste("+"),
		["*"] = require("vim.ui.clipboard.osc52").paste("*"),
	},
}

require("vim._core.ui2").enable {
  enable = true,
  msg = { -- Options related to the message module.
    ---@type 'cmd'|'msg' Default message target, either in the
    ---cmdline or in a separate ephemeral message window.
    ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
    ---or table mapping |ui-messages| kinds and triggers to a target.
    targets = "cmd",
    cmd = { -- Options related to messages in the cmdline window.
      height = 0.5, -- Maximum height while expanded for messages beyond 'cmdheight'.
    },
    dialog = { -- Options related to dialog window.
      height = 0.5, -- Maximum height.
    },
    msg = { -- Options related to msg window.
      height = 0.5, -- Maximum height.
      timeout = 4000, -- Time a message is visible in the message window.
    },
    pager = { -- Options related to message window.
      height = 0.5, -- Maximum height.
    },
  },
}
