local ls = require("luasnip")
require("luasnip.loaders.from_lua").lazy_load()

local env = SnipEnv

ls.add_snippets("go", {
  env.s(
	{trig="iferr", name="Error Handling", snippetType="autosnippet", desc="Generic golang error handling, with switchable propagation using plain, errors.WithStack or errors.Wrapf", wordTrig=true},
	{
	  env.t({"if err != nil {", ""}),
	  env.t("\treturn "),
	  env.c(1, {
		env.t("err"),
		env.t("errors.WithStack(err)"),
		env.t("errors.Wrapf(err, \"\")"),
	  }),
	  env.t({"", "}"}),
	}
  ),
  env.s(
	{trig="ifsrv", name="API V3 Error Handling", snippetType="autosnippet", desc="API V3 Error Handling", wordTrig=true},
	{
	  env.t({"if err != nil {", ""}),
	  env.t({"\tsrv.handleError(w, r, err, \"\")", ""}),
	  env.t({"\treturn", ""}),
	  env.t({"", "}",}),
	}
  ),
  env.s(
	{trig="swc", name="Switch case", snippetType="snippet", desc="Golang switch completion", wordTrig=true},
	{
	  env.t("switch "), env.i(1, "variable"), env.t({"{", ""}),
	  env.t({"\tcase "}), env.i(2, "condition"), env.t({":", ""}),
	  env.t({"","}"})
	}
  ),
  env.s(
	{ trig = "pf", name = "Formatted Print", snippetType="snippet", dscr = "Insert a formatted print statement" },
	{
	  env.t("fmt.Printf(\"%v\\n\", "), env.i(1, "value"), env.t(")"),
	}
  )
})
