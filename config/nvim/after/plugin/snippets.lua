local ls = require("luasnip")
local env = SnipEnv

vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<Right>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<Left>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
  if ls.choice_active() then
	ls.change_choice(1)
  end
end, {silent = true})

-- date returns current date in YYYY-MM-DD hh:mm format
local date = function ()
  return { os.date("%Y-%m-%d %H:%M") }
end

local signature = function ()
  return { "Maurizio Dominici"}
end

ls.add_snippets(nil, {
  all = {
	env.s(
	  {
		trig = "date",
		namr = "Date",
		dscr = "Date in the form of YYYY-MM-DD hh:mm",
	  }, {
		env.func(date, {}),
	  }
	),
	env.s(
	  {
		trig = "sig",
		namr = "Signature",
		dscr = "insert signature"
	  }, {
		env.func(signature, {})
	  }
	),
  },
})

