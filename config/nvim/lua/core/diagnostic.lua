local diagnostic = vim.diagnostic

local M = {
  diagnostics = true,
}

local function skip_buffer(bufnr)
  return vim.bo[bufnr].buftype == "prompt"
end

M.config = function(opts)
  opts = opts or {}

  if opts.diagnostics ~= nil then
    M.diagnostics = opts.diagnostics
  end

  diagnostic.config({
    signs = {
      text = {
        [diagnostic.severity.ERROR] = "",
        [diagnostic.severity.WARN]  = "",
        [diagnostic.severity.HINT]  = "",
        [diagnostic.severity.INFO]  = "",
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
        min = diagnostic.severity.ERROR,
      }
    },
  })

  -- tiny-inline-diagnostic: show inline only for non-error severities (errors use virtual_lines)
  require("tiny-inline-diagnostic").setup({
    options = {
      severity = {
        diagnostic.severity.WARN,
        diagnostic.severity.INFO,
        diagnostic.severity.HINT,
      },
    },
  })

  diagnostic.enable(M.diagnostics)
end

M.status_diagnostic = function()
  return M.diagnostics
end

M.disable_diagnostic = function(filter)
  diagnostic.enable(false, filter)
end

M.toggle_diagnostic = function(filter)
  M.diagnostics = not M.diagnostics
  diagnostic.enable(M.diagnostics, filter)
end

M.enable_diagnostic = function(filter)
  diagnostic.enable(M.diagnostics, filter)
end

-- Disable diagnostics in Insert mode.
-- When Insert mode is left, display diagnostics according to the module state.
vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("DiagnosticsToggle", { clear = true }),
  callback = function(args)
    if skip_buffer(args.buf) then
      return
    end

    local filter = { bufnr = args.buf }
    if args.event == "InsertEnter" then
      M.disable_diagnostic(filter)
      return
    end

    M.enable_diagnostic(filter)
  end,
})

return M
