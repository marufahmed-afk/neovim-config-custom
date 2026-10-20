vim.g.mapleader = " "
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.o.number = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.undofile = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.scrolloff = 8
vim.o.signcolumn = "yes"

vim.keymap.set("n", "J", "5j", {})
vim.keymap.set("n", "K", "5k", {})
