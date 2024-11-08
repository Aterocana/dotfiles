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

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {'gopls', 'rust_analyzer', 'lua_ls'},
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require('lspconfig').lua_ls.setup(lua_opts)
		end,
	}
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_action = require('lsp-zero').cmp_action()
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
--
-- If you want insert `(` after select function or method item
cmp.event:on(
	'confirm_done',
	cmp_autopairs.on_confirm_done()
)

-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
-- require('luasnip.loaders.from_vscode').lazy_load()

local lspkind = require('lspkind')
cmp.setup({
	snippet = {
		expand = function (args)
			local ls = require("luasnip")
			ls.lsp_expand(args.body)
		end
	},
	mapping = cmp.mapping.preset.insert({
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<C-Space>'] = cmp.mapping.complete(),
		['<Tab>'] = cmp_action.tab_complete(),
		['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
	}),
	sources = {
		{name = 'nvim_lsp'},
		{name = 'luasnip'},
		--{name = 'buffer', keyword_length = 3},
		--{name = 'path'},
		--{name = 'nvim_lua'},
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol', -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
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
	experimental = {
		ghost_text = true
	},
})
