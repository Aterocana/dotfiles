require('telescope').setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules",
			"vendor",
		},
		hidden = true,
	},
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-g>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

