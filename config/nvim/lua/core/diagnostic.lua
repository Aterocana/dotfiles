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
    style  = "minimal",
    border = "single",
    source = "always",
    header = "",
    prefix = "",
    suffix = "",
  },
  virtual_text = {
    current_line = true,
    severity = {
      max = vim.diagnostic.severity.WARN,
    }
  },
  virtual_lines = {
    severity = {
      min = vim.diagnostic.severity.ERROR,
    }
  },
})

-- Disabilita i diagnostic nella riga corrente in insert mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  callback = function()
    local bt = vim.bo.buftype
    if bt == "prompt" then
      return -- ignora Telescope e simili
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
