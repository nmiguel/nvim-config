vim.g.mapleader = " "

-- make all keymaps silent by default
local _keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return _keymap_set(mode, lhs, rhs, opts)
end

local map = vim.keymap.set

map("i", "<C-H>", "<C-W>")
map("n", "<leader>oe", "<cmd>silent !xdg-open %:h<cr>")

map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "J", ":m '>+1<CR>gv=gv")

-- map("n", "J", "mzJ`z$")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "G", "Gzzzv")

map("x", "<leader>p", [["_dP]])

map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

map({ "n", "v" }, "<leader>d", [["_d]])

map("n", "Q", "<c-v>")
map("n", "<leader>p", "<nop>") -- I press this so much before deciding on telescope

map("v", "gk", ":norm gcc<CR>")

map("v", ">", ">gv")
map("v", "<", "<gv")

map("n", "j", "gj", { noremap = true })
map("n", "k", "gk", { noremap = true })
map("n", "gp", "`[v`]", { noremap = true })

local function smart_split(key, direction, fallback_cmd)
  map("n", key, function()
    local curwin = vim.api.nvim_get_current_win()
    vim.cmd("wincmd " .. direction)
    if curwin == vim.api.nvim_get_current_win() then
      vim.cmd(fallback_cmd)
    end
  end, { noremap = true, silent = true })
end

smart_split("<C-h>", "h", "vsplit")
smart_split("<C-j>", "j", "split | wincmd j")
smart_split("<C-k>", "k", "split ")
smart_split("<C-l>", "l", "vsplit | wincmd l")

-- map('x', '<leader>f', ':fold<cr>', { noremap = true })

