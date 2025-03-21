local ls = require("luasnip")
local f = ls.function_node
local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

-- Repeats the node in the specified position
-- rep(<position>)
local rep = require("luasnip.extras").rep
local snippet_from_nodes = ls.sn

local ts_locals = require "nvim-treesitter.locals"
local ts_utils = require "nvim-treesitter.ts_utils"
local get_node_text = vim.treesitter.get_node_text

local function go_error(info)
  return c(info.index, {
	-- Old style (pre 1.13, see https://go.dev/blog/go1.13-errors), using
	-- https://github.com/pkg/errors
	t(string.format('errors.Wrap(%s, "%s")', info.err_name, info.func_name)),
	t(string.format('errors.Wrapf(%s, "%s")', info.err_name, info.func_name)),
	t(string.format('fmt.Errorf("%s: %%v", %s)', info.func_name, info.err_name)),
	t(info.err_name),
	-- Be cautious with wrapping, it makes the error part of the API of the
	-- function, see https://go.dev/blog/go1.13-errors#whether-to-wrap
	t(string.format('fmt.Errorf("%s: %%w", %s)', info.func_name, info.err_name)),
  })
end

local function same(index)
  return f(function (args)
	return args[1]
  end, {index})
end

-- search throgh treesitter for:
-- method_declaration (func receiver)
-- function_declaration (func)
-- func_literal (anonymous func assigned to variable)
vim.treesitter.query.set(
  "go",
  "LuaSnip_Result",
  [[ [
	(method_declaration result: (_) @id)
	(function_declaration result: (_) @id)
	(func_literal result: (_) @id)
  ] ]]
)

-- Adapted from https://github.com/tjdevries/config_manager/blob/1a93f03dfe254b5332b176ae8ec926e69a5d9805/xdg_config/nvim/lua/tj/snips/ft/go.lua
-- transform returns default value for `text` go type. `info` provides choice for errors.
local transform = function(text, info)
  if text == "int" then
	return t "0"
  elseif text == "error" then
	if info then
	  info.index = info.index + 1

	  return go_error(info)

	  --	  return c(info.index, {
	  --		-- Old style (pre 1.13, see https://go.dev/blog/go1.13-errors), using
	  --		-- https://github.com/pkg/errors
	  --		t(string.format('errors.Wrap(%s, "%s")', info.err_name, info.func_name)),
	  --		t(string.format('errors.Wrapf(%s, "%s")', info.err_name, info.func_name)),
	  --		t(string.format('fmt.Errorf("%s: %%v", %s)', info.func_name, info.err_name)),
	  --		t(info.err_name),
	  --		-- Be cautious with wrapping, it makes the error part of the API of the
	  --		-- function, see https://go.dev/blog/go1.13-errors#whether-to-wrap
	  --		t(string.format('fmt.Errorf("%s: %%w", %s)', info.func_name, info.err_name)),
	  --	  })
	else
	  return t "err"
	end
  elseif text == "bool" then
	return t "false"
  elseif text == "string" then
	return t '""'
  elseif string.find(text, "*", 1, true) then
	return t "nil"
  end

  return t(text)
end

local handlers = {
  ["parameter_list"] = function(node, info)
	local result = {}

	local count = node:named_child_count()
	for idx = 0, count - 1 do
	  table.insert(result, transform(get_node_text(node:named_child(idx), 0), info))
	  if idx ~= count - 1 then
		table.insert(result, t { ", " })
	  end
	end

	return result
  end,

  ["type_identifier"] = function(node, info)
	local text = get_node_text(node, 0)
	return { transform(text, info) }
  end,
}

-- Adapted from https://github.com/tjdevries/config_manager/blob/1a93f03dfe254b5332b176ae8ec926e69a5d9805/xdg_config/nvim/lua/tj/snips/ft/go.lua
local function go_result_type(info)
  local cursor_node = ts_utils.get_node_at_cursor()
  local scope = ts_locals.get_scope_tree(cursor_node, 0)

  local function_node
  for _, v in ipairs(scope) do
	if
	  v:type() == "function_declaration"
	  or v:type() == "method_declaration"
	  or v:type() == "func_literal"
	then
	  function_node = v
	  break
	end
  end

  local query = vim.treesitter.query.get("go", "LuaSnip_Result")
  for _, node in query:iter_captures(function_node, 0) do
	if handlers[node:type()] then
	  return handlers[node:type()](node, info)
	end
  end

  return { t "nil" }
end

-- go_ret_vals returns the error name and the function name from an expression like `myerr := fn()`.
-- the returned object has the following shape: {index: snippet node index, err_name: myerr, func_name: fn}
local go_ret_vals = function(args)
  return snippet_from_nodes(
	nil,
	go_result_type {
	  index = 0,
	  err_name = args[1][1],
	  func_name = args[2][1],
	}
  )
end

ls.add_snippets("go", {
  -- Adapted from https://github.com/tjdevries/config_manager/blob/1a93f03dfe254b5332b176ae8ec926e69a5d9805/xdg_config/nvim/lua/tj/snips/ft/go.lua
  s({trig="feh", name="Function Error Handling", snippetType="autosnippet", desc = "Go Function with Error Handling", wordTrgi=true}, {
	i(1, { "val" }),
	t ", ",
	i(2, { "err" }),
	t " := ",
	i(3, { "f" }),
	t "(",
	i(4),
	t ")",
	t { "", "if " },
	same(2),
	t { " != nil {", "\treturn " },
	d(5, go_ret_vals, { 2, 3 }),
	t { "", "}" },
	i(0),
  }),
  s({trig="iferr", name="Error Handling", snippetType="autosnippet", desc = "Go Error Handling", wordTrgi=true}, {
	--  t "if ",
	--  i(1, { "err"}),
	--  t {" != nil; {", "\treturn "},
	--  go_error({
	--  'index': 1,
	--  'err_name': same(1),
	--  'func_name': "error",
	--	}),



	t { "if err != nil {", "\treturn " },
	d(1, go_ret_vals, { 1, 2 }),
	t { "", "}" },
	i(0),
  }),
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

