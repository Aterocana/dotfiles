local inlay_hints = true -- set it to preferred default value (true or false)
local hints = vim.lsp.inlay_hint
hints.enable(inlay_hints) -- initialize to desire behavior

local M = {}

M.status_hint = function ()
  return inlay_hints
end

M.disable_hint = function (filter)
  hints.enable(false, filter)
end

M.toggle_hint = function (filter)
  inlay_hints = not inlay_hints
  hints.enable(inlay_hints, filter)
end

M.enable_hint = function (filter)
  hints.enable(inlay_hints, filter)
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
