require('nvim-treesitter.configs').setup {
  ensure_installed = "go",
}

require('nvim-biscuits').setup({
    cursor_line_only = true,
	default_config = {
		max_length = 128,
		min_distance = 5,
		prefix_string = " 📎"
	},
	toggle_keybind = "<leader>cb",
})
