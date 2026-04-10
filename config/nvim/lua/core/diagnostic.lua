vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.HINT]  = "",
      [vim.diagnostic.severity.INFO]  = "",
    },
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style     = "minimal",
    border    = "single",
    source    = true,
    if_many   = false,
    header    = "",
    prefix    = "",
    suffix    = "",
  },
  virtual_text = false, -- tiny-inline-diagnostic handles current-line display
  virtual_lines = {
    severity = {
      min = vim.diagnostic.severity.ERROR,
    }
  },
})

-- tiny-inline-diagnostic: show inline only for non-error severities (errors use virtual_lines)
require("tiny-inline-diagnostic").setup({
  options = {
    severity = {
      vim.diagnostic.severity.WARN,
      vim.diagnostic.severity.INFO,
      vim.diagnostic.severity.HINT,
    },
  },
})

-- Disabilita i diagnostic nella riga corrente in insert mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  callback = function()
    local bt = vim.bo.buftype
    if bt == "prompt" then
      return
    end
    vim.diagnostic.enable(false)
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function()
    local bt = vim.bo.buftype
    if bt == "prompt" then
      return
    end
    vim.diagnostic.enable(true)
  end,
})
