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
	['<c-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
	['<c-e>'] = { 'hide', 'fallback' },
	['<enter>'] = { 'select_and_accept', 'fallback' },
	['<c-y>'] = { 'select_and_accept', 'fallback' },

	['<c-k>'] = { 'select_prev', 'fallback' },
	['<c-j>'] = { 'select_next', 'fallback' },
	['<c-p>'] = { 'select_prev', 'fallback_to_mappings' },
	['<c-n>'] = { 'select_next', 'fallback_to_mappings' },

	['<c-b>'] = { 'scroll_documentation_up', 'fallback' },
	['<c-f>'] = { 'scroll_documentation_down', 'fallback' },

	['<tab>'] = { 'snippet_forward', 'fallback' },
	['<s-tab>'] = { 'snippet_backward', 'fallback' },

	['<c-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
  },
  snippets = {
	preset = "luasnip",
  },
}

return M
