local ls = require("luasnip")

ls.add_snippets("go", {
  ls.snippet("fn", {
	ls.text_node("func "), ls.insert_node(1, "name"), ls.text_node("("),
	ls.insert_node(2, "params"), ls.text_node(") {"),
	ls.insert_node(3, "\n\t"), ls.text_node("}"),
  }),
})
