vim.g.mapleader = " "

vim.keymap.set("i", "<C-H>", "<C-W>", { noremap = true })
vim.keymap.set("n", "<leader>oe", "<cmd>silent !explorer.exe .<cr>", { noremap = true })

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "G", "Gzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v"} , "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set( {"n", "v" } , "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<c-v>")
vim.keymap.set("n", "<leader>p", "<nop>") -- I press this so much before deciding on telescope

vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz")

vim.keymap.set("v", "gk", ":norm gcc<CR>")

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
