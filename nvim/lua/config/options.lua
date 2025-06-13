vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.termguicolors = true
-- Search improvements
vim.opt.ignorecase = true       -- Case insensitive search
vim.opt.smartcase = true        -- But case sensitive when uppercase present

-- Editor experience
vim.opt.wrap = true            --  wrap lines
vim.opt.scrolloff = 8           -- Start scrolling when 8 lines from edge
vim.opt.sidescrolloff = 8       -- Start scrolling horizontally 8 chars from edge
vim.opt.mouse = "a"             -- Enable mouse in all modes

-- Visual indicators
vim.opt.signcolumn = "yes"      -- Always show sign column for git/lsp
vim.opt.colorcolumn = "100"      -- Show column at 80 chars
vim.opt.list = true             -- Show invisible characters
vim.opt.listchars = { tab = "┃ ", trail = "·" }  -- Symbols for tabs and trailing spaces

-- Files and backups
vim.opt.swapfile = false        -- Don't create swap files
vim.opt.backup = true          -- create backup files
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")  -- Persistent undo history
vim.opt.undofile = true         -- Enable persistent undo

-- Window splitting
vim.opt.splitbelow = true       -- Open horizontal splits below current window
vim.opt.splitright = true       -- Open vertical splits to the right

-- Faster updates
vim.opt.updatetime = 50         -- More responsive updates (default is 4000ms)

local pywal = require("pywal16.core").get_colors()

vim.api.nvim_command("highlight IndentBlanklineChar guifg=" .. pywal.foreground .. " guibg=" .. pywal.color0)
