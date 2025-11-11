local nvim_events = vim.api.nvim_create_augroup("NvimLifecycleNotify", {})

-- On Neovim start
vim.api.nvim_create_autocmd("VimEnter", {
  group = nvim_events,
  callback = function()
    vim.system({ "notify-send", "🟢 Neovim started" }, { text = true }, function(obj)
      -- print(obj.code)
      -- print(obj.signal)
      -- print(obj.stdout)
      -- print(obj.stderr)
    end)
  end,
})

-- On Neovim exit
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = nvim_events,
  callback = function()
    vim.system({ "notify-send", "🔴 Neovim closing" }, { text = true }, function(obj)
      -- print(obj.code)
      -- print(obj.signal)
      -- print(obj.stdout)
      -- print(obj.stderr)
    end)
  end,
})

-- On regaining focus
vim.api.nvim_create_autocmd("FocusGained", {
  group = nvim_events,
  callback = function()
    vim.system({ "notify-send", "🔵 Neovim focused" }, { text = true }, function(obj)
      -- print(obj.code)
      -- print(obj.signal)
      -- print(obj.stdout)
      -- print(obj.stderr)
    end)
  end,
})

-- On losing focus
vim.api.nvim_create_autocmd("FocusLost", {
  group = nvim_events,
  callback = function()
    vim.system({ "notify-send", "⚫ Neovim unfocused" }, { text = true }, function(obj)
      -- print(obj.code)
      -- print(obj.signal)
      -- print(obj.stdout)
      -- print(obj.stderr)
    end)
  end,
})
