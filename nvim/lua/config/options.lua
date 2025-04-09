vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.termguicolors = true

local pywal = require("pywal16.core").get_colors()


vim.api.nvim_command("highlight IndentBlanklineChar guifg=pywal.foreground guibg=NONE")
