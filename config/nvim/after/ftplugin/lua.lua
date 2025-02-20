vim.opt_local.shiftwidth = 2
-- Before saving a lua file (BufWritePre) run go format.
local format_sync_grp = vim.api.nvim_create_augroup("AutoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.lua",
  command = ":normal gg=G",
  group = format_sync_grp,
})
