local ls = require("luasnip")
local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

local function create_code_block(tag)
  return s({ trig = tag.."_block", name = tag.." Code Block", snippetType = "snippet", desc = "Insert a Code Block for "..tag.." Language"},
	{
	  t({ "```"..tag, ""}),
	  i(1),
	  t({"", "```"}),
	})
end

local desired_languages_code_blocks = {
  "go", "bash", "toml", "lua", "c", "cpp", "csv", "dockerfile"
}

local snippets = {}

for _, lang in ipairs(desired_languages_code_blocks) do
  table.insert(snippets, create_code_block(lang))
end

ls.add_snippets("markdown", snippets)
