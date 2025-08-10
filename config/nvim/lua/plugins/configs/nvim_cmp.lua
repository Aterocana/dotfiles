local M = {
  event = { "InsertEnter", "CmdlineEnter" },
  config = function ()
	local cmp = require('cmp')
	local lspkind = require('lspkind')

	vim.opt.signcolumn = "yes"

	vim.api.nvim_create_autocmd('LspAttach', {
	  desc = 'LSP actions',
	  callback = function (event)
		local opts = {buffer = event.buf}
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- see popup definition
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- goto definition
		vim.keymap.set("n", "<M-LeftMouse>", vim.lsp.buf.definition, opts) -- goto definition with mouse
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts) -- goto type definition
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts) -- goto implementation
		vim.keymap.set("n", "<leader>vws",vim.lsp.buf.workspace_symbol, opts)

		vim.keymap.set("n", "<leader>di", "<cmd>Telescope diagnostics<CR>", opts)
		vim.keymap.set("n", "<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
	  end,
	})

	require('plugins.configs.lsp').all_servers_config()

	local luasnip = require('luasnip')
	cmp.setup({
	  snippet = {
		expand = function (args)
		  luasnip.lsp_expand(args.body)
		end
	  },
	  window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered()
	  },
	  mapping = cmp.mapping.preset.insert({
		['<CR>'] = cmp.mapping(function(fallback)
		  if cmp.visible() then
			if luasnip.expandable() then
			  luasnip.expand()
			else
			  cmp.confirm({
				select = true,
				behavior = cmp.ConfirmBehavior.Replace,
			  })
			end
		  else
			fallback()
		  end
		end),

		["<C-j>"] = cmp.mapping(function(fallback)
		  if cmp.visible() then
			cmp.select_next_item()
		  elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		  else
			fallback()
		  end
		end, {"i", "s"}),

		["<C-k>"] = cmp.mapping(function(fallback)
		  if cmp.visible() then
			cmp.select_prev_item()
		  elseif luasnip.jumpable(-1) then
			luasnip.jump(-1)
		  else
			fallback()
		  end
		end, {"i", "s"}),

		['<C-e>'] = cmp.mapping.abort(),
	  }),
	  sources = cmp.config.sources({
		{name = 'nvim_lsp', keyword_length = 2 },
		{name = "nvim_lsp_signature_help" },
		{name = 'luasnip'},
		{name = 'path'},
		{name = 'nvim_lua'},
	  }, {name = 'buffer', keyword_length = 3}),
	  formatting = {
		formatting = {
		  fields = { "abbr", "kind", "menu" },
		  format = function(entry, vim_item)
			vim_item.kind = kind_icons[vim_item.kind]
			vim_item.menu = ({
			  luasnip = "[SNP]",
			  nvim_lua = "[LUA]",
			  nvim_lsp = "[LSP]",
			  buffer = "[BUF]",
			  path = "[PTH]",
			  emoji = "[EMO]",
			})[entry.source.name]

			-- max len of item, and with padding...
			local ELLIPSIS_CHAR = "…"
			local MAX_LABEL_WIDTH = 40
			local MIN_LABEL_WIDTH = 20

			local label = vim_item.abbr
			local truncated_label =
			vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
			if truncated_label ~= label then
			  vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
			elseif string.len(label) < MIN_LABEL_WIDTH then
			  local padding =
			  string.rep(" ", MIN_LABEL_WIDTH - string.len(label))
			  vim_item.abbr = label .. padding
			end
			return vim_item
		  end,
		},
	  },
	  experimental = {
		ghost_text = true
	  },
	})

	-- If you want insert `(` after select function or method item
	cmp.event:on(
	  'confirm_done',
	  require('nvim-autopairs.completion.cmp').on_confirm_done()
	)

  end
}

return M
