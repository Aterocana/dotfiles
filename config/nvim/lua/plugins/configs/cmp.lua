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
		columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
		treesitter = { "lsp" },
		components = {
		  kind_icon = {
			ellipsis = false,
			text = function(ctx) return ctx.kind_icon .. ctx.icon_gap end,
			-- Set the highlight priority to 20000 to beat the cursorline's default priority of 10000
			highlight = function(ctx) return { { group = ctx.kind_hl, priority = 20000 } } end,
		  },
		  kind = {
			ellipsis = false,
			width = { fill = true },
			text = function(ctx) return ctx.kind end,
			highlight = function(ctx) return ctx.kind_hl end,
		  },

		  label = {
			width = { fill = true, max = 60 },
			text = function(ctx) return ctx.label .. ctx.label_detail end,
			highlight = function(ctx)
			  -- label and label details
			  local highlights = {
				{ 0, #ctx.label, group = ctx.deprecated and 'BlinkCmpLabelDeprecated' or 'BlinkCmpLabel' },
			  }
			  if ctx.label_detail then
				table.insert(highlights, { #ctx.label, #ctx.label + #ctx.label_detail, group = 'BlinkCmpLabelDetail' })
			  end

			  -- characters matched on the label by the fuzzy matcher
			  for _, idx in ipairs(ctx.label_matched_indices) do
				table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
			  end

			  return highlights
			end,
		  },

		  label_description = {
			width = { max = 30 },
			text = function(ctx) return ctx.label_description end,
			highlight = 'BlinkCmpLabelDescription',
		  },

		  source_name = {
			width = { max = 30 },
			text = function(ctx) return ctx.source_name end,
			highlight = 'BlinkCmpSource',
		  },

		  source_id = {
			width = { max = 30 },
			text = function(ctx) return ctx.source_id end,
			highlight = 'BlinkCmpSource',
		  },
		},
	  },

	  winblend = 0,
	  auto_show = true,
	  auto_show_delay_ms = 100,
	},
	documentation = {
	  auto_show = true,
	  auto_show_delay_ms = 200,
	},
	ghost_text = {
	  enabled = true,
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
  signature = { enabled = true },
}

return M
