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
					ls.config.setup({
						enable_autosnippets = true,
					})
				end
			},
		},
	},
}
