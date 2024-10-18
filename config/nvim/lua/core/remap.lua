vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Oil)

-- Visual mode: use J and K to move selected portion down or up.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Normal mode: scroll down or up half of the page and apply zz (center vertically on cursor)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Navigate through windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Split Windows
vim.keymap.set("n", "<leader>|", ":vsplit<CR>")
vim.keymap.set("n", "<leader>-", ":split<CR>")

-- Substitution
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- open Lazy Packet Manager UI
vim.keymap.set("n", "<leader>L", vim.cmd.Lazy)

-- (visual mode) paste selection in system clipboard
vim.keymap.set("v", "<leader>y", '"+y"', {})

-- terminal
local exitTerm = function ()
	vim.cmd(":ToggleTerm");
end

vim.keymap.set({"t", "n", "i", "v"}, "<ESC><ESC>", exitTerm)
vim.keymap.set("n", "<leader>db", '<CMD>DBUIToggle<CR>')
