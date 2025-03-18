local ls = require("luasnip")

local s = ls.s
local i = ls.i
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("lua", {
  s("req", fmt("local {} = require('{}')", { i(1, "default"), rep(1) }))
  --	s({ trig = "req", name = "require module", snippetType = "snippet", dscr = "Require a Lua module"},
  --	  {
  --		fmt("local {} = require('{}')"),
  --		{
  --		  i(1, "default"),
  --		  rep(1),
  --		}
  --	  }),
})
