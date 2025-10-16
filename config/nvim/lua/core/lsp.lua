vim.lsp.enable('lua_ls')
vim.lsp.enable('gopls')
vim.lsp.enable('bashls')

vim.api.nvim_create_autocmd('LspAttach', {
  desc = "LSP Actions",
  callback = function(event)
	local client = vim.lsp.get_client_by_id(event.data.client_id)
	if not client then
	  return
	end

	local opts = {buffer = event.buf}

	if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
	  vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
	  vim.lsp.completion.enable( true, client.id, event.buf, { autotrigger = true })

	  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- see popup definition
	  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- goto definition
	  vim.keymap.set("n", "<M-LeftMouse>", vim.lsp.buf.definition, opts) -- goto definition with mouse
	  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts) -- goto type definition
	  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts) -- goto implementation

	  vim.keymap.set("n", "<leader>di", "<cmd>Telescope diagnostics<CR>", opts)
	  vim.keymap.set("n", "<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", opts)
	  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
	  vim.keymap.set('i', '<C-Space>', function()
		vim.lsp.completion.trigger()
	  end, { desc = "manual LSP completion"})

	  vim.keymap.set('n', '<leader>td', function ()
		vim.diagnostic.enable(not vim.diagnostic.is_enabled())
	  end, {desc = "[T]oggle [D]iagnostics"})

	  -- Diagnostic keymaps
	  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
	  -- Navigate definitions in new buffers
	  vim.keymap.set("n", "gD", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", { desc = 'Go To Definition in a new Tab'})
	  vim.keymap.set("n", "gT", "<cmd>vsplit | lua vim.lsp.buf.type_definition()<CR>", { desc = 'Go To Definition in a new Tab'})

	  local has_luasnip, luasnip = pcall(require, "luasnip")

	  vim.keymap.set("i", "<C-j>", function()
		if vim.fn.pumvisible() == 1 then
		  return "<C-n>"  -- next
		elseif has_luasnip and luasnip.jumpable(1) then
		  luasnip.jump(1)
		end
		return "<C-j>"
	  end, { expr = true, silent = true })

	  vim.keymap.set("i", "<C-k>", function()
		if vim.fn.pumvisible() == 1 then
		  return "<C-p>"  -- previous
		elseif has_luasnip and luasnip.jumpable(-1) then
		  luasnip.jump(-1)
		end
		return "<C-k>"
	  end, { expr = true, silent = true })

	  -- <Tab> e <S-Tab> come in cmp
	  vim.keymap.set("i", "<Tab>", function()
		if vim.fn.pumvisible() == 1 then
		  return "<C-n>"
		elseif has_luasnip and luasnip.expand_or_jumpable() then
		  luasnip.expand_or_jump()
		  return ""
		else
		  return "<Tab>"
		end
	  end, { expr = true, silent = true })


	  vim.keymap.set("i", "<S-Tab>", function()
		if vim.fn.pumvisible() == 1 then
		  return "<C-p>"
		elseif has_luasnip and luasnip.jumpable(-1) then
		  luasnip.jump(-1)
		  return ""
		else
		  return "<S-Tab>"
		end
	  end, { expr = true, silent = true })

	  -- <CR> per confermare selezione
	  --   vim.keymap.set("i", "<CR>", function()
	  --  if vim.fn.pumvisible() == 1 then
	  --    return vim.fn["pum#map#confirm"]()
	  --  end
	  --  return "<CR>"
	  --   end, { expr = true, silent = true })
	  --
	  --  vim.keymap.set("i", "<C-j>", function()
	  -- return vim.fn.pumvisible() == 1 and "<C-n>" or "<C-j>"
	  --  end, { expr = true, silent = true })
	  --
	  --  vim.keymap.set("i", "<C-k>", function()
	  -- return vim.fn.pumvisible() == 1 and "<C-p>" or "<C-k>"
	  --  end, { expr = true, silent = true })
	  --
	  --  vim.keymap.set("i", "<CR>", function()
	  -- return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
	  --  end, { expr = true, silent = true })
	end
  end,
})


local icons = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = "󰊕 ",
  Interface = " ",
  Keyword = " ",
  Method = "ƒ ",
  Module = "󰏗 ",
  Property = " ",
  Snippet = " ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

local completion_kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(completion_kinds) do
  completion_kinds[i] = icons[kind] and icons[kind] .. kind or kind
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.foldingRange = {
  dynamicRegistration = true,
  lineFoldingOnly = true,
}

capabilities.textDocument.semanticTokens.multilineTokenSupport = true
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config("*", {
  capabilities = capabilities,
  -- on_attach = function ()
  -- end
})
