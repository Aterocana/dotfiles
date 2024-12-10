return {
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "VonHeikemen/lsp-zero.nvim", branch = "v4.x" },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/cmp-nvim-lsp" },
  {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
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
		config = function ()
		  local ls = require("luasnip")
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
		  }
		end
	  },
	},
  },
}
