local ls = require("luasnip")
require("luasnip.loaders.from_lua").lazy_load()

local env = SnipEnv

local errWrap = function ()
  return env.fmt([[
	errors.Wrapf({}, "{}")
	]], {
	  env.i(1, "err"),
	  env.i(2, ""),
	})
end

local errStack = function ()
  return env.fmt("errors.WithStack({})", {
	env.i(1, "err")
  })

end

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
	  env.t({"}"}),
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
--  env.s(
--	{trig="dbtx", name="Start a DB tx with special ctx", snippetType="autosnippet", desc="dlabscore/db transactional context wrapper", wordTrig=true},
--	{
--	  env.t({"cctx, err := db.getTxfromCtx(ctx)", ""}),
--	  env.t({"if err != nil {", ""}),
--	  env.t("\treturn "),
--	  env.c(1, {
--		env.t("errors.WithStack(err)"),
--		env.t("err"),
--		env.t("errors.Wrapf(err, \"\")"),
--	  }),
--	  env.t({"", "}", ""}),
--	  env.t("defer cctx.Rollback()"),
--	  env.t("")
--	}
--  ),
--  env.s(
--	{trig="dbcm", name="Commit a DB tx with special ctx", snippetType="snippet", desc="dlabscore/db transactional context wrapper commit", wordTrig=true},
--	{
--	  env.t({"cctx.Commit()"}),
--	}
--  ),
  env.s(
	{ trig = "pf", name = "Formatted Print", snippetType="snippet", dscr = "Insert a formatted print statement" },
	{
	  env.t("fmt.Printf(\"%v\\n\", "), env.i(1, "value"), env.t(")"),
	}
  ),
  env.s(
	{ trig = "errwrap", name = "Auto Error Wrapped", snippetType="autosnippet", desc = "error wrapped with errors.Wrapf"},
	{ errWrap(), }
  ),
  env.s(
	{ trig = "errwrap", name = "Error Wrapped", snippetType="snippet", desc = "error wrapped with errors.Wrapf"},
	{ errWrap(), }
  ),
  env.s(
	{ trig = "errstack", name = "Auto Error With Stack", snippetType="autosnippet", desc = "error with errors.WithStack"},
	{ errStack(), }
  ),
  env.s(
	{ trig = "errstack", name = "Error With Stack", snippetType="snippet", desc = "error with errors.WithStack"},
	{ errStack(), }
  )
})
