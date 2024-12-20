local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "[A]dd current buffer to Harpoon"})
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu"})

vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end, {desc = "[P]revious Harpoon buffer"})
vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end, {desc = "[P]revious Harpoon buffer"})
vim.keymap.set("n", "<leader>1", function () harpoon:list():select(1) end, {desc = "Harpoon buffer 1"})
vim.keymap.set("n", "<leader>2", function () harpoon:list():select(2) end, {desc = "Harpoon buffer 2"})
vim.keymap.set("n", "<leader>3", function () harpoon:list():select(3) end, {desc = "Harpoon buffer 3"})
vim.keymap.set("n", "<leader>4", function () harpoon:list():select(4) end, {desc = "Harpoon buffer 4"})
vim.keymap.set("n", "<leader>5", function () harpoon:list():select(5) end, {desc = "Harpoon buffer 5"})
vim.keymap.set("n", "<leader>6", function () harpoon:list():select(6) end, {desc = "Harpoon buffer 6"})
vim.keymap.set("n", "<leader>7", function () harpoon:list():select(7) end, {desc = "Harpoon buffer 7"})
vim.keymap.set("n", "<leader>8", function () harpoon:list():select(8) end, {desc = "Harpoon buffer 8"})
vim.keymap.set("n", "<leader>9", function () harpoon:list():select(9) end, {desc = "Harpoon buffer 9"})
