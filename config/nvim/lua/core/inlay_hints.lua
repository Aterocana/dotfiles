local hints = vim.lsp.inlay_hint

local M = {}

M.config = function (opts)
  opts = opts or {inlay_hints = false}
  M.inlay_hints = opts.inlay_hints
  hints.enable(M.inlay_hints) -- initialize to desire behavior
end

M.status_hint = function ()
  return M.inlay_hints
end

M.disable_hint = function (filter)
  hints.enable(false, filter)
end

M.toggle_hint = function (filter)
  M.inlay_hints = not M.inlay_hints
  hints.enable(M.inlay_hints, filter)
end

M.enable_hint = function (filter)
  hints.enable(M.inlay_hints, filter)
end

-- disable inlay hints when enter in Insert mode.
-- When Insert mode is leaved, display hints according to InlayHints global variable
vim.api.nvim_create_autocmd({'LspAttach', 'InsertEnter', 'InsertLeave'}, {
  callback = function (args)
	local filter = { bufnr = args.buf}
	if args.event == "InsertEnter" then
	  M.disable_hint(filter)
	  return
	end
	M.enable_hint(filter)
  end
})


return M
