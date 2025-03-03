return {
  { "williamboman/mason.nvim", config=function ()
	require('mason').setup({
	  ensure_installed = {
		"gopls",
		"dockerls",
		"bashls",
	  },
	})
  end },
  {
	"williamboman/mason-lspconfig.nvim",
	config = function ()
	  local lsp_zero = require('lsp-zero')
	  local opts = {
		ensure_installed = {'gopls', 'lua_ls'},
		handlers = {
		  lsp_zero.default_setup,
		  lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require('lspconfig').lua_ls.setup(lua_opts)
		  end,
		}
	  }
	  require('mason-lspconfig').setup(opts)
	end,
  },
  {
	"VonHeikemen/lsp-zero.nvim", branch = "v4.x",
	config = function ()
	  local lsp_zero = require('lsp-zero')

	  lsp_zero.on_attach(function(client, bufnr)
		local opts = {buffer = bufnr, remap = false}

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
		vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
	  end)
	end
  },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-nvim-lsp-signature-help" },
  { "hrsh7th/cmp-nvim-lua" },
  { "hrsh7th/cmp-path" },
  {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	config = function()
	  local cmp = require('cmp')
	  --local cmp_select = {behavior = cmp.SelectBehavior.Select}
	  local cmp_action = require('lsp-zero').cmp_action()
	  --	  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
	  --	  --
	  --	  -- If you want insert `(` after select function or method item
	  --	  cmp.event:on(
	  --		'confirm_done',
	  --		cmp_autopairs.on_confirm_done()
	  --	  )

	  -- this is the function that loads the extra snippets to luasnip
	  -- from rafamadriz/friendly-snippets
	  -- require('luasnip.loaders.from_vscode').lazy_load()

	  local lspkind = require('lspkind')
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
				})
			  end
			else
			  fallback()
			end
		  end),
		  --  ['<CR>'] = cmp.mapping.confirm({
		  --	behavior = cmp.ConfirmBehavior.Insert,
		  --	select = true,
		  --  }),
		  ['<C-Space>'] = cmp.mapping.complete(),
		  ['<Tab>'] = cmp_action.tab_complete(),
		  ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
		}),
		sources = {
		  {name = 'nvim_lsp', keyword_length = 2 },
		  {name = "nvim_lsp_signature_help" },
		  {name = 'luasnip'},
		  {name = 'buffer', keyword_length = 3},
		  {name = 'path'},
		  {name = 'nvim_lua'},
		},
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
	end,
	dependencies = {
	  {
		"onsails/lspkind-nvim",
		event = "InsertEnter",
	  },
	  {
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
	  },
	  {
		"L3MON4D3/LuaSnip",
		-- dependencies = {
		-- 	{"rafamadriz/friendly-snippets"},
		-- },
		version = "v2.*",
		build = "make install_jsregexp",
		lazy = false,
		dependencies = { "saadparwaiz1/cmp_luasnip" },
		config = function ()
		  local ls = require("luasnip")
		  local types = require("luasnip.util.types")
		  ls.setup({})
		  ls.config.setup({
			history =true,
			update_events = "TextChanged,TextChangedI",
			enable_autosnippets = true,
		  })
		  SnipEnv = {
			s = require("luasnip.nodes.snippet").S,
			sn = require("luasnip.nodes.snippet").SN,
			t = require("luasnip.nodes.textNode").T,
			f = require("luasnip.nodes.functionNode").F,
			i = require("luasnip.nodes.insertNode").I,
			c = require("luasnip.nodes.choiceNode").C,
			d = require("luasnip.nodes.dynamicNode").D,
			r = require("luasnip.nodes.restoreNode").R,
			l = require("luasnip.extras").lambda,
			rep = require("luasnip.extras").rep,
			p = require("luasnip.extras").partial,
			m = require("luasnip.extras").match,
			n = require("luasnip.extras").nonempty,
			dl = require("luasnip.extras").dynamic_lambda,
			fmt = require("luasnip.extras.fmt").fmt,
			fmta = require("luasnip.extras.fmt").fmta,
			conds = require("luasnip.extras.expand_conditions"),
			types = require("luasnip.util.types"),
			events = require("luasnip.util.events"),
			parse = require("luasnip.util.parser").parse_snippet,
			ai = require("luasnip.nodes.absolute_indexer"),
			func = ls.function_node,
		  }
		end
	  },
	},
  },
  {
	"micangl/cmp-vimtex",
	ft = "tex",
	config = function()
	  require('cmp_vimtex').setup({})
	end,
  },
}
