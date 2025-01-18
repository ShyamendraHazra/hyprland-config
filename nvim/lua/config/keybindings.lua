vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

--  quick fix menu
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

-- Neotree

vim.keymap.set("n", "<space>el", ":Neotree left<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<space>er", ":Neotree right<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<space>eb", ":Neotree bottom<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<space>ef", ":Neotree float<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<space>ec", ":Neotree close<CR>", { noremap = true, silent = true })
