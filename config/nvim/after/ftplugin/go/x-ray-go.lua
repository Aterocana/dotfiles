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

