vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

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

-- vim.o.winborder = 'rounded'

-- Open help in vertical split
vim.cmd("cnorea h vert bo help")

-- Use ripgrep
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"

vim.opt.showmode = false

vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 20
vim.opt.foldenable = false

function _G.CustomFoldText()
    local indent = vim.fn.indent(vim.v.foldstart)
    local spacing = string.rep(" ", indent)
    local start = vim.fn.getline(vim.v.foldstart):gsub("^%s*", "")
    return spacing .. start .. " ... " .. vim.fn.getline(vim.v.foldend):gsub("^%s*", "")
end
vim.opt.foldtext = "v:lua.CustomFoldText()"

-- Disable deprecation warnings
---@diagnostic disable-next-line: duplicate-set-field
vim.deprecate = function() end
