vim.api.nvim_set_keymap('n', '<leader>im', [[<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>]], { desc = "Go [IM]plementations" ,noremap=true, silent=true})
vim.keymap.set("n", "<M-f>", ":GoFillStruct<CR>", {desc = "fill go struct with default values"})
vim.keymap.set("n", "<M-j>", ":GoAddTag<CR>", {desc = "fill go struct with JSON tags"})
vim.keymap.set("n", "<leader>ca", ":GoCodeAction<CR>", {desc = "Go [C]ode [A]ction"})
