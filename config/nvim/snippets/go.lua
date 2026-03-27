local ls = require("luasnip")
local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt

-- Map a Go type string to its zero value string.
-- Returns nil for the "error" type (handled as a choice node by the caller).
local function go_zero_value(type_str)
  type_str = vim.trim(type_str)
  if type_str == "error" then return nil end
  if type_str == "string" then return '""' end
  if type_str == "bool" then return "false" end
  local numerics = {
    "int", "int8", "int16", "int32", "int64",
    "uint", "uint8", "uint16", "uint32", "uint64", "uintptr",
    "float32", "float64", "complex64", "complex128",
    "byte", "rune",
  }
  for _, n in ipairs(numerics) do
    if type_str == n then return "0" end
  end
  if type_str:sub(1, 1) == "*"
    or type_str:sub(1, 2) == "[]"
    or type_str:match("^map%[")
    or type_str:match("^chan[ <]")
    or type_str:match("^interface{")
    or type_str:match("^func%(")
  then
    return "nil"
  end
  -- Named / package-qualified struct type
  return type_str .. "{}"
end

-- Use treesitter to get the return types and type parameter names of the
-- function enclosing the cursor.
-- Returns: types (list of type strings), type_params (set of type param names)
local function get_enclosing_func_info()
  local bufnr = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1 -- 0-indexed

  local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "go")
  if not ok then return nil, {} end

  local trees = parser:parse()
  local tree = trees[1]
  if not tree then return nil, {} end

  local node = tree:root():named_descendant_for_range(row, col, row, col)

  -- Walk up to the nearest function node
  local func_node = node
  while func_node do
    local typ = func_node:type()
    if typ == "function_declaration" or typ == "method_declaration" or typ == "func_literal" then
      break
    end
    func_node = func_node:parent()
  end
  if not func_node then return nil, {} end

  -- Collect type parameter names (e.g. T, K, V from [T any, K comparable])
  local type_params = {}
  local tparams = func_node:field("type_parameters")
  if tparams and #tparams > 0 then
    for child in tparams[1]:iter_children() do
      if child:type() == "type_parameter_declaration" then
        for _, name_node in ipairs(child:field("name")) do
          type_params[vim.treesitter.get_node_text(name_node, bufnr)] = true
        end
      end
    end
  end

  local result = func_node:field("result")
  if not result or #result == 0 then return nil, type_params end

  local result_node = result[1]
  local types = {}

  if result_node:type() == "parameter_list" then
    for child in result_node:iter_children() do
      if child:type() == "parameter_declaration" then
        local type_fields = child:field("type")
        if type_fields and #type_fields > 0 then
          local type_text = vim.treesitter.get_node_text(type_fields[1], bufnr)
          -- count names to handle "a, b int" → two ints
          local name_fields = child:field("name")
          local count = math.max(1, #name_fields)
          for _ = 1, count do
            table.insert(types, type_text)
          end
        end
      end
    end
  else
    table.insert(types, vim.treesitter.get_node_text(result_node, bufnr))
  end

  return #types > 0 and types or nil, type_params
end

local function is_generic(type_str)
  -- Has [...] but is not a slice ([]T) or map (map[K]V)
  return type_str:match("%[") ~= nil
    and not type_str:match("^%[%]")
    and not type_str:match("^map%[")
end

local function iferr_handler()
  local types, type_params = get_enclosing_func_info()
  local parts = {}
  local var_decls = {}
  local choice_idx = 1

  local function needs_var(typ)
    return type_params[typ] or is_generic(typ)
  end

  if types then
    -- count var-needing types to decide naming (single → "zero", multiple → "zero1", "zero2", ...)
    local var_count = 0
    for _, typ in ipairs(types) do
      if go_zero_value(typ) and needs_var(typ) then var_count = var_count + 1 end
    end

    local var_idx = 0
    for j, typ in ipairs(types) do
      if j > 1 then table.insert(parts, t(", ")) end
      local zero = go_zero_value(typ)
      if not zero then
        table.insert(parts, c(choice_idx, {
          t("err"),
          t('fmt.Errorf("%w: ", err)'),
        }))
        choice_idx = choice_idx + 1
      elseif needs_var(typ) then
        var_idx = var_idx + 1
        local var_name = var_count == 1 and "zero" or ("zero" .. var_idx)
        table.insert(var_decls, "var " .. var_name .. " " .. typ)
        table.insert(parts, t(var_name))
      else
        table.insert(parts, t(zero))
      end
    end
  else
    table.insert(parts, c(1, {
      t("err"),
      t('fmt.Errorf("%w: ", err)'),
    }))
  end

  local nodes = {}
  for _, decl in ipairs(var_decls) do
    table.insert(nodes, t({ decl, "" }))
  end
  table.insert(nodes, t({ "if err != nil {", "\treturn " }))
  for _, p in ipairs(parts) do
    table.insert(nodes, p)
  end
  table.insert(nodes, t({ "", "}" }))

  return sn(nil, nodes)
end

ls.add_snippets("go", {
  s(
    { trig = "iferr", name = "error handling", snippetType = "autosnippet", desc = "Error handling with inferred return types", wordTrig = true },
    d(1, iferr_handler)
  ),
  s(
    { trig = "ifsrv", name = "API V3 Error Handling", snippetType = "autosnippet", desc = "API V3 Error Handling", wordTrig = true },
    {
      t({ "if err != nil {", "" }),
      t({ "\tsrv.handleError(w, r, err, \"\")", "" }),
      t({ "\treturn", "" }),
      t({ "}" }),
    }
  ),
  s(
    { trig = "httpdo", name = "HTTP perform request", snippetType = "snippet", desc = "Go perform HTTP request" },
    fmt("resp, err := {}.Do({})", {
      i(1, "http.DefaultClient"),
      i(2, "req"),
    })
  ),
  s(
    { trig = "swc", name = "Switch case", snippetType = "snippet", desc = "Golang switch completion", wordTrig = true },
    {
      t("switch "), i(1, "variable"), t({ "{", "" }),
      t({ "\tcase " }), i(2, "condition"), t({ ":", "" }),
      t({ "", "}" }),
    }
  ),
  s(
    { trig = "pf", name = "Formatted Print", snippetType = "snippet", dscr = "Insert a formatted print statement" },
    {
      t("fmt.Printf(\"%v\\n\", "), i(1, "value"), t(")"),
    }
  ),
  s(
    { trig = "timefmt", name = "time.Time placeholder format", snippetType = "snippet", desc = "Insert the time.Time.Format placeholder format" },
    {
      c(1, {
        t("\"2006-01-02T15:04:05Z07:00\""),
        t("\"Mon Jan 02 15:04:05 MST 2006\""),
      }),
    }
  ),
})
