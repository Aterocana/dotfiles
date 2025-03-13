vim.keymap.set("n", "<SPACE><SPACE>x", "<CMD>source %<CR>", {desc = "load current buffer"})
vim.keymap.set("n", "<SPACE>x", ":.lua<CR>", {desc = "execute current lua line"})
vim.keymap.set("v", "<SPACE>x", ":lua<CR>", {desc = "execute current lua Visual Selection"})
