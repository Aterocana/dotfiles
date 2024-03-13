return  {
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{
		'hrsh7th/nvim-cmp',
		event = "InsertEnter",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function() 
			require("luasnip.loaders.from_vscode").lazy_load()
		end
	},
}
