local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require('go.format').goimport()
	end,
	group = format_sync_grp,
})
require('go').setup({
	tag_options = 'json=omitempty',
	comment_placeholder = "complete here",
	dap_debug_gui = true,
	luasnip = true,
	lsp_inlay_hints = {
		enable = true,
		-- hint style, set to 'eol' for end-of-line hints, 'inlay' for inline hints
		-- inlay only avalible for 0.10.x
		style = 'inlay',
		-- Event which triggers a refersh of the inlay hints.
		-- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
		-- not that this may cause higher CPU usage.
		-- This option is only respected when only_current_line and
		-- autoSetHints both are true.
		only_current_line_autocmd = "CursorHold",
		-- whether to show variable name before type hints with the inlay hints or not
		-- default: false
		show_variable_name = true,
		-- prefix for parameter hints
		parameter_hints_prefix = "󰊕 ",
		show_parameter_hints = true,
		-- prefix for all the other hints (type, chaining)
		other_hints_prefix = "=> ",
		-- whether to align to the lenght of the longest line in the file
		max_len_align = false,
		-- padding from the left if max_len_align is true
		max_len_align_padding = 1,
		-- whether to align to the extreme right or not
		right_align = false,
		-- padding from the right if right_align is true
		right_align_padding = 6,
		-- The color of the hints
		highlight = "Comment",
	},
})

require("structrue-go").setup({
	show_others_method = true, -- bool show methods of struct whose not in current file
	show_filename = true, -- bool
	number = "no", -- show number: no | nu | rnu
	fold_open_icon = "  ",
	fold_close_icon = "  ",
	cursor_symbol_hl = "guibg=Gray guifg=White", -- symbol hl under cursor,
	indent = "┠",  -- Hierarchical indent icon, nil or empty will be a tab
	position = "botright", -- window position,default botright,also can set float
	symbol = { -- symbol style
		filename = {
		    hl = "guifg=#0096C7", -- highlight symbol
		    icon = " " -- symbol icon
		},
		package = {
		    hl = "guifg=#0096C7",
		    icon = " "
		},
		import = {
		    hl = "guifg=#0096C7",
		    icon = " ◈ "
		},
		const = {
		    hl = "guifg=#E44755",
		    icon = " π ",
		},
		variable = {
		    hl = "guifg=#52A5A2",
		    icon = " ◈ ",
		},
		func = {
		    hl = "guifg=#CEB996",
		    icon = "   ",
		},
		interface = {
		    hl = "guifg=#00B4D8",
		    icon = "❙ "
		},
		type = {
		    hl = "guifg=#00B4D8",
		    icon = "▱ ",
		},
		struct = {
		    hl = "guifg=#00B4D8",
		    icon = "❏ ",
		},
		field = {
		    hl = "guifg=#CEB996",
		    icon = " ▪ "
		},
		method_current = {
		    hl = "guifg=#CEB996",
		    icon = " ƒ "
		},
		method_others = {
		    hl = "guifg=#CEB996",
		    icon = "   "
		},
	},
	keymap = {
		toggle = "<leader>m", -- toggle structure-go window
		show_others_method_toggle = "H", -- show or hidden the methods of struct whose not in current file
		symbol_jump = "<CR>", -- jump to then symbol file under cursor
		center_symbol = "\\f", -- Center the highlighted symbol
		fold_toggle = "\\z",
		refresh = "R", -- refresh symbols
		preview_open = "P", -- preview  symbol context open
		preview_close = "\\p" -- preview  symbol context close
	},
	fold = { -- fold symbols
		import = true,
		const = false,
		variable = false,
		type = false,
		interface = false,
		func = false,
	},
})
require("hierarchy-tree-go").setup({
	icon = {
		fold = "", -- fold icon
		unfold = "", -- unfold icon
		func = "₣", -- symbol
		last = '☉', -- last level icon
	},
	hl = {
		current_module = "guifg=Green", -- highlight cwd module line
		others_module = "guifg=Black", -- highlight others module line
		cursorline = "guibg=Gray guifg=White" -- hl  window cursorline
	},
	keymap = {
		--global keymap
		incoming = "<space>fi", -- call incoming under cursorword
		outgoing = "<space>fo", -- call outgoing under cursorword
		open = "<space>ho", -- open hierarchy win
		close = "<space>hc", -- close hierarchy win
		-- focus: if hierarchy win is valid but is not current win, set to current win
		-- focus: if hierarchy win is valid and is current win, close
		-- focus  if hierarchy win not existing,open and focus
		focus = "<space>fu",

		-- bufkeymap
		expand = "o", -- expand or collapse hierarchy
		jump = "<CR>", -- jump
		move = "<space><space>" -- switch the hierarchy window position, must be current win
	}
})
