local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmta = require("luasnip.extras.fmt").fmta

vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "C-n", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "C-p", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

ls.add_snippets("go", {
	s({trig="iferr", name="Error Handling", snippetType="autosnippet", desc="Generic golang error handling, with switchable propagation using plain, errors.WithStack or errors.Wrapf", wordTrig=true},
		{
			t({"if err != nil {", ""}),
			t("\treturn "),
			c(1, {
				t("err"),
				t("errors.WithStack(err)"),
				t("errors.Wrapf(err, \"\")"),
			}),
			t({"", "}"}),
		}
	),
	s(
		{trig="ifsrv", name="API V3 Error Handling", snippetType="autosnippet", desc="API V3 Error Handling", wordTrig=true},
		{
			t({"if err != nil {", ""}),
			t({"\tsrv.handleError(w, r, err, \"\")", ""}),
			t({"\treturn", ""}),
			t({"", "}",}),
		}
	),
	s(
		{trig="switch", name="Switch case", snippetType="snippet", desc="Golang switch completion", wordTrig=true},
		{
			t("switch "), i(1, "variable"), t({"{", ""}),
			t({"\tcase "}), i(2, "condition"), t({":", ""}),
			t({"","}"})
		}
	)
})
