local pick = require("mini.pick")
local pickcore = require("core.pick")
vim.keymap.set("n", "<leader>pf", pickcore.pick_files_filters({
  '/vendor/',
  '^vendor/'
}), { desc = "[P]ick [F]iles" })
vim.keymap.set('n', '<C-g>', pickcore.live_grep, { desc = 'Live grep (search file contents)' })
vim.keymap.set("n", "<leader>pd", pickcore.pick_diagnostics, { desc = "[P]ick LSP [D]iagnostics" })
vim.keymap.set("n", "<leader>pb", pick.builtin.buffers, { desc = "[P]ick open [B]uffers" })
vim.keymap.set("n", "<leader>ph", pick.builtin.help, { desc = "[P]ick [H]elp pages" })
vim.keymap.set("n", "<leader>pkm", pickcore.pick_keymappings, { desc = "List all key mapping" })
vim.keymap.set("n", "<leader>pr", pick.builtin.resume, { desc = "[P]ick [R]esume" })
vim.keymap.set("n", "<leader>pc", pickcore.custom, { desc = "[P]ick [R]esume" })
