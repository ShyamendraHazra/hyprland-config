--
local opts = { noremap = true, silent = true }
--
-- lua specific

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")


--  quick fix menu
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")


-- Floating terminal

vim.keymap.set("n", "<space>tf", ":Floaterminal<CR>", { noremap = true, nowait = true, silent = true })

-- Neotree

vim.keymap.set("n", "<space>el", ":Neotree left<CR>", opts)
vim.keymap.set("n", "<space>er", ":Neotree right<CR>", opts)
vim.keymap.set("n", "<space>eb", ":Neotree bottom<CR>", opts)
vim.keymap.set("n", "<space>ef", ":Neotree float<CR>", opts)
vim.keymap.set("n", "<space>ec", ":Neotree close<CR>", opts)

-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<space>bc', ':bdelete!<CR>', opts)   -- close buffer
vim.keymap.set('n', '<space>bo', '<cmd> enew <CR>', opts) -- new buffer

-- Pywal toggle bg
vim.keymap.set('n', '<space>tb', ':ToggleBg<CR>', opts)
