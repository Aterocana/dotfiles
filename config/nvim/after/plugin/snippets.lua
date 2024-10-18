local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
--vim.keymap.set({"i", "s"}, "<Tab>", function() ls.jump( 1) end, {silent = true})
--vim.keymap.set({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

ls.add_snippets("lua", {
	s("hello", {
		t('print("hello world")')
	})
})

ls.add_snippets("go", {
	s(
		"iferr",
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
		"ifsrv",
		{
			t({"if err != nil {", ""}),
			t({"\tsrv.handleError(w, r, err, \"\")", ""}),
			t({"\treturn", ""}),
			t({"", "}",}),
		}
	)
})
