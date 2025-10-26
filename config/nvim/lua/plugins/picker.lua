local opts = {
  delay = { async = 10, busy = 50 },

  mappings = {
	caret_left  = '<Left>',
	caret_right = '<Right>',

	choose            = '<CR>',
	choose_in_split   = '<C-s>',
	choose_in_tabpage = '<C-t>',
	choose_in_vsplit  = '<C-v>',
	choose_marked     = '<M-CR>',

	delete_char       = '<BS>',
	delete_char_right = '<Del>',
	delete_left       = '<C-u>',
	delete_word       = '<C-w>',

	mark     = '<C-x>',
	mark_all = '<C-a>',

	move_down  = '<C-j>',
	move_start = '<C-g>',
	move_up    = '<C-k>',

	paste = '<C-r>',

	refine        = '<C-Space>',
	refine_marked = '<M-Space>',

	scroll_down  = '<C-f>',
	scroll_up    = '<C-b>',

	stop = '<Esc>',

	toggle_info    = '<S-Tab>',
	toggle_preview = '<Tab>',
  },

  options = { content_from_bottom = false, use_cache = true },

  window = { prompt_caret = '▏', prompt_prefix = '> ' }
}

return {
  {
	'nvim-mini/mini.pick',
	version = false ,
	dependencies = { 'nvim-mini/mini.extra', version = false },
	config = function ()
	  require("mini.pick").setup(opts)
	end
  },
}
