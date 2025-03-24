local nvim_cmp_opts = require("plugins.configs.nvim_cmp")
local luasnip_opts = require("plugins.configs.luasnip")

return {
  { "williamboman/mason.nvim", config=function ()
	require('mason').setup({})
  end },
  {	"williamboman/mason-lspconfig.nvim",
	config = function ()
	  local opts = {
		ensure_installed = {'gopls', 'dockerls', 'lua_ls', 'bashls'},
	  }
	  require('mason-lspconfig').setup(opts)
	end,
  },
  { "neovim/nvim-lspconfig",
	dependencies = {
	  {
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
		  library = {
			-- See the configuration section for more details
			-- Load luvit types when the `vim.uv` word is found
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		  },
		},
	  },
	}
  },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-nvim-lsp-signature-help" },
  { "hrsh7th/cmp-nvim-lua" },
  { "hrsh7th/cmp-path" },
  {	"hrsh7th/nvim-cmp",
	event = nvim_cmp_opts.event,
	config = nvim_cmp_opts.config,
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
		config = luasnip_opts.config,
	  },
	},
  },
  {	"micangl/cmp-vimtex",
	ft = "tex",
	config = function()
	  require('cmp_vimtex').setup({})
	end,
  },
  {
	'stevearc/aerial.nvim',
	config = require("plugins.configs.aerial").setup,
	dependencies = {
	  "nvim-treesitter/nvim-treesitter",
	  "nvim-tree/nvim-web-devicons"
	},
  },
}
