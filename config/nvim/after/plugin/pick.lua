local pick = require("mini.pick")
local pickcore = require("core.pick")
local extra = require("mini.extra")
vim.keymap.set("n", "<leader>pf", pickcore.pick_files_filters({
  '/vendor/',
  '^vendor/'
}), { desc = "[P]ick [F]iles" })
vim.keymap.set('n', '<C-g>', pickcore.live_grep, { desc = 'Live grep (search file contents)' })
vim.keymap.set("n", "<leader>pd", pickcore.pick_diagnostics, { desc = "[P]ick LSP [D]iagnostics" })
vim.keymap.set("n", "<leader>pb", pick.builtin.buffers, { desc = "[P]ick open [B]uffers" })
vim.keymap.set("n", "<leader>ph", pick.builtin.help, { desc = "[P]ick [H]elp pages" })
vim.keymap.set("n", "<leader>pkm", extra.pickers.keymaps, { desc = "[P]ick List all [K]ey [M]apping" })
vim.keymap.set("n", "<leader>pm", extra.pickers.marks, { desc = "[P]ick [M]arks" })
vim.keymap.set("n", "<leader>pr", extra.pickers.registers, { desc = "[P]ick [R]egisters" })
vim.keymap.set("n", "<leader>pp", pick.builtin.resume, { desc = "[P]ick Resume" })
