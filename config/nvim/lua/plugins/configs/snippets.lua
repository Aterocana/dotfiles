local M = {}
M.config = function ()
  local ls = require("luasnip")
  local types = require("luasnip.util.types")
  require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })

  ls.setup({})
  ls.config.setup({
	history = true,
	update_events = "TextChanged,TextChangedI,InsertLeave",
	enable_autosnippets = true,
	ext_opts = {
	  [types.choiceNode] = {
		active = {
		  virt_text = { { "󰁍", "DiagnosticHint" } },
		},
		unvisited = {
		  virt_text = {},
		},
	  },
	},
  })

  vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
  vim.keymap.set({"i", "s"}, "<Right>", function() ls.jump( 1) end, {silent = true})
  vim.keymap.set({"i", "s"}, "<Left>", function() ls.jump(-1) end, {silent = true})

  vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
	  ls.change_choice(1)
	end
  end, {silent = true})

end
return M
