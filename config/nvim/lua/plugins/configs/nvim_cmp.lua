local M = {
  event = { "InsertEnter", "CmdlineEnter" },
  config = function ()
	local cmp = require('cmp')
	local lspkind = require('lspkind')
	local lspconfig = require('lspconfig')

	vim.opt.signcolumn = "yes"
	local lspconfig_default = lspconfig.util.default_config
	lspconfig_default.capabilities = vim.tbl_deep_extend(
	  'force',
	  lspconfig_default.capabilities,
	  require('cmp_nvim_lsp').default_capabilities()
	)

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
		vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>vr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
	  end,
	})
	vim.api.nvim_create_autocmd({'LspAttach', 'InsertEnter', 'InsertLeave'}, {
	  callback = function (args)
		local enabled = args.event ~= 'InsertEnter'
		vim.lsp.inlay_hint.enable(enabled, {bufnr = args.buf})
	  end
	})

	require('lspconfig').gopls.setup({
	  capabilities = lspconfig_default.capabilities,
	  analyses = {
		shadow = true,
		unusedwrite = true,
		unusedvariable = true,
	  },
	  staticcheck = true,
	  gofumpt = true,

	  settings = {
		gopls = {
		  hints = {
			assignVariableTypes = true,
			compositeLiteralFields = true,
			compositeLiteralTypes = true,
			constantValues = true,
			functionTypeParameters = true,
			parameterNames = true,
			rangeVariableTypes = true,
		  },
		  usePlaceholders = false,
		  analyses = {
			unusedvariable = true
		  }
		}
	  }
	})
	require('lspconfig').lua_ls.setup({
	  on_init = function(client)
		--if client.workspace_folders then
		--  local path = client.workspace_folders[1].name
		--  if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc')) then
		--    return
		--  end
		--end

		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
		  runtime = { version = 'LuaJIT' },
		  -- Make the server aware of Neovim runtime files
		  workspace = {
			checkThirdParty = false,
			library = {
			  vim.env.VIMRUNTIME
			  -- Depending on the usage, you might want to add additional paths here.
			  -- "${3rd}/luv/library"
			  -- "${3rd}/busted/library",
			}
			-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
			-- library = vim.api.nvim_get_runtime_file("", true)
		  }
		})
	  end,

	  settings = {
		Lua = {
		  runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
		  diagnostic = { globals = {"vim"}},
		  workspace = {
			-- Make the server aware of Neovim runtime files
			library = vim.api.nvim_get_runtime_file("", true),
		  },
		  -- Do not send telemetry data containing a randomized but unique identifier
		  telemetry = {
			enable = false,
		  },

		  hint = {enable = true},
		}
	  },
	})

	local luasnip = require('luasnip')
	cmp.setup({
	  snippet = {
		expand = function (args)
		  luasnip.lsp_expand(args.body)
		end
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

		["<Tab>"] = cmp.mapping(function(fallback)
		  if cmp.visible() then
			cmp.select_next_item()
		  elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		  else
			fallback()
		  end
		end, {"i", "s"}),

		["<S-Tab>"] = cmp.mapping(function(fallback)
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
		format = lspkind.cmp_format({
		  mode = 'symbol_text', -- show only symbol annotations
		  maxwidth = 70, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
		  -- can also be a function to dynamically calculate max width such as
		  -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
		  ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
		  show_labelDetails = true, -- show labelDetails in menu. Disabled by default

		  -- The function below will be called before any actual modifications from lspkind
		  -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
		  before = function (entry, vim_item)
			return vim_item
		  end
		})
	  },
	  window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered()
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
