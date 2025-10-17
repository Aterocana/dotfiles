local M = {}

M.opts = {
  appearance = { nerd_font_variant = 'mono' },
  completion = {
	accept = {
	  auto_brackets = {
		enabled = true,
	  },
	},
	menu = {
	  draw = {
		treesitter = { "lsp" },
	  },
	},
	documentation = {
	  auto_show = true,
	  auto_show_delay_ms = 200,
	},
	ghost_text = {
	  enabled = vim.g.ai_cmp,
	},
	list = { cycle = { from_top = true }},
  },
  sources = {
	default = { "lsp", "path", "snippets", "buffer" },
  },
  cmdline = {
	enabled = false,
	keymap = { preset = 'inherit' },
	completion = {
	  list = { selection = { preselect = false } },
	  menu = {
		auto_show = function(ctx)
		  return vim.fn.getcmdtype() == ":"
		end,
	  },
	  ghost_text = { enabled = true },
	},
  },
  keymap = {
	preset = "none",
	["<C-j>"] = { "select_next", "fallback" },
	["<C-k>"] = { "select_prev", "fallback" },
	["<Enter>"] = { "accept", "fallback" },

  },
  snippets = {
	preset = "luasnip",
	expand = function (snippet, _)
	  require("luasnip").lsp_expand(snippet.body)
	end
  },
}

return M
