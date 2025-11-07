-- absolute numer in INSERT mode, relative in other modes
local line_numbers_toggle_grp = vim.api.nvim_create_augroup("LineNumbersToggle", { clear = true })

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  desc = "set absolute line numbers when entering Insert mode",
  group = line_numbers_toggle_grp,
  callback = function()
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  desc = "set relative line numbers when leaving Insert mode",
  group = line_numbers_toggle_grp,
  callback = function()
    vim.opt.relativenumber = true
  end,
})
