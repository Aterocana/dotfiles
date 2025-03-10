vim.opt_local.shiftwidth = 2

vim.keymap.set("n", "<SPACE><SPACE>x", "<CMD>source %<CR>", {desc = "load current buffer"})
vim.keymap.set("n", "<SPACE>x", ":.lua<CR>", {desc = "execute current lua line"})
vim.keymap.set("v", "<SPACE>x", ":lua<CR>", {desc = "execute current lua Visual Selection"})

-- Before saving a lua file (BufWritePre) run go format.
local format_sync_grp = vim.api.nvim_create_augroup("AutoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.lua",
  command = ":normal gg=G",
  --command = ":normal gg=G",
  group = format_sync_grp,
})
