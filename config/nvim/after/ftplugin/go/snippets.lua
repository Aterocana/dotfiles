local ls = require("luasnip")
local f = ls.function_node
local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("go", {
  s(
	{trig="iferr", name="error handling", snippetType="autosnippet", desc="Default Error handling", wordTrig=true,},
	{
	  t("if err != nil {"),
	  t({"", "\treturn "}),
	  c(1, {
		t("err"),
		t("fmt.Errorf(\"%w: \", err)")
	  }),
	  t({"", "}"})
	}
  ),
  s(
	{trig="ifsrv", name="API V3 Error Handling", snippetType="autosnippet", desc="API V3 Error Handling", wordTrig=true},
	{
	  t({"if err != nil {", ""}),
	  t({"\tsrv.handleError(w, r, err, \"\")", ""}),
	  t({"\treturn", ""}),
	  t({"}"}),
	}
  ),
  s(
	{trig="httpdo", name="HTTP perform request", snippetType="snippet", desc="Go perform HTTP request"},
	{
	  fmt("resp, err := {}.Do({})", {
		i(1, "http.DefaultClient"),
		i(2, "req"),
	  }),
	}
  ),
  s(
	{trig="swc", name="Switch case", snippetType="snippet", desc="Golang switch completion", wordTrig=true},
	{
	  t("switch "), i(1, "variable"), t({"{", ""}),
	  t({"\tcase "}), i(2, "condition"), t({":", ""}),
	  t({"","}"})
	}
  ),
  s(
	{ trig = "pf", name = "Formatted Print", snippetType="snippet", dscr = "Insert a formatted print statement" },
	{
	  t("fmt.Printf(\"%v\\n\", "), i(1, "value"), t(")"),
	}
  ),
  s(
	{ trig = "timefmt", name = "time.Time placeholder format", snippetType = "snippet", desc = "Insert the time.Time.Format placeholder format"},
	{
	  c( 1,
	  {
		t("\"2006-01-02T15:04:05Z07:00\""),
		t("\"Mon Jan 02 15:04:05 MST 2006\"")
	  }
	)
  }
)
})
