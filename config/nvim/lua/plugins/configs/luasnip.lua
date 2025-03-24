M = {
  config = function ()
	local ls = require("luasnip")
	local types = require("luasnip.util.types")
	ls.setup({})
	ls.config.setup({
	  history = true,
	  update_events = "TextChanged,TextChangedI",
	  enable_autosnippets = true,
	  ext_opts = {
		[types.choiceNode] = {
		  active = {
			virt_text = { { "<-", "Error" } },
		  },
		},
	  },
	})
  end
}

return M
