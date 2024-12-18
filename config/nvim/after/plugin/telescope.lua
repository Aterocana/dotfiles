local telescope = require("telescope")

telescope.setup({
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            "vendor",
        },
        hidden = true,
    },
})

telescope.load_extension("git_file_history")

local builtin = require('telescope.builtin')

-- search for files
vim.keymap.set('n', '<leader>ph', builtin.help_tags, {desc = "find files in workspace"})
vim.keymap.set('n', '<leader>pf', builtin.find_files, {desc = "find files in workspace"})

-- search for string in files
vim.keymap.set('n', '<C-g>', builtin.live_grep, { desc = "find string in code"}) -- in telescope window
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end, { desc = "find string in code previously filtered by a grep work"}) -- previously filter by grep word

vim.api.nvim_set_keymap('n', '<leader>im', [[<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>]], {noremap=true, silent=true})
