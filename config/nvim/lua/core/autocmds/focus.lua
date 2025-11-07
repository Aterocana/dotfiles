local focus_grp = vim.api.nvim_create_augroup("FocusCommands", {})

vim.api.nvim_create_autocmd("FocusGained", {
  group = focus_grp,
  callback = function()
    vim.fn.jobstart({ "notify-send", "Back to Neovim" })
  end,
})

vim.api.nvim_create_autocmd("FocusLost", {
  group = focus_grp,
  callback = function()
    vim.fn.jobstart({ "notify-send", "Left Neovim" })
  end,
})
