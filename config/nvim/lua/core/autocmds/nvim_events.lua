local nvim_events = vim.api.nvim_create_augroup("NvimLifecycleNotify", {})

-- On Neovim start
vim.api.nvim_create_autocmd("VimEnter", {
  group = nvim_events,
  callback = function()
    vim.fn.jobstart({ "notify-send", "🟢 Neovim started" })
  end,
})

-- On Neovim exit
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = nvim_events,
  callback = function()
    vim.fn.jobstart({ "notify-send", "🔴 Neovim closing" })
  end,
})

-- On regaining focus
vim.api.nvim_create_autocmd("FocusGained", {
  group = nvim_events,
  callback = function()
    vim.fn.jobstart({ "notify-send", "🔵 Neovim focused" })
  end,
})

-- On losing focus
vim.api.nvim_create_autocmd("FocusLost", {
  group = nvim_events,
  callback = function()
    vim.fn.jobstart({ "notify-send", "⚫ Neovim unfocused" })
  end,
})
