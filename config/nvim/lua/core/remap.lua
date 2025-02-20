vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Oil, { desc = "Open file manager in current directory" })
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle [U]ndotree buffer" })

-- Visual mode: use J and K to move selected portion down or up.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc = "Move selected portion down"})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc = "Move selected portion up"})

-- Visual mode: indent selection right or left
vim.keymap.set("v", "<", "<gv", {desc= "indent selection to the left"})
vim.keymap.set("v", ">", ">gv", {desc= "indent selection to the right"})

-- Normal mode: scroll down or up half of the page and apply zz (center vertically on cursor)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Navigate through windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Down Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Up Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Right Window" })

-- Windows Managing
vim.keymap.set("n", "<leader>|", ":vsplit<CR>", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>-", ":split<CR>", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>wK", "<CMD>windcmd K<CR>", { desc = "Move [w]indow UP" })
vim.keymap.set("n", "<leader>wJ", "<CMD>windcmd J<CR>", { desc = "Move [w]indow DOWN" })
vim.keymap.set("n", "<leader>wH", "<CMD>windcmd H<CR>", { desc = "Move [w]indow LEFT" })
vim.keymap.set("n", "<leader>wL", "<CMD>windcmd L<CR>", { desc = "Move [w]indow RIGHT" })
vim.keymap.set("n", "<leader>wk", "<CMD>resize +5<CR>", { desc = "Resize [w]indow UP" })
vim.keymap.set("n", "<leader>wj", "<CMD>resize -5<CR>", { desc = "Resize [w]indow DOWN" })
vim.keymap.set("n", "<leader>wh", "<CMD>vertical resize +3<CR>", { desc = "Resize [w]indow LEFT" })
vim.keymap.set("n", "<leader>wl", "<CMD>vertical resize -3<CR>", { desc = "Resize [w]indow RIGHT" })

-- Substitution
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "[S]ubstitution on current word"})

-- open Lazy Packet Manager UI
vim.keymap.set("n", "<leader>L", vim.cmd.Lazy, { desc = "Open [L]azyNVim Manager"})

-- (visual mode) paste selection in system clipboard
vim.keymap.set("v", "<leader>y", '"+y"', { desc = "[Y]ank into system clipboard"})

-- toggle debugger
vim.keymap.set("n", "<leader>db", '<CMD>DBUIToggle<CR>', {desc = "Toggle [D]e[B]ug view"})

-- toggle hidden characters
vim.keymap.set("n", "<leader>h", ":set list!<CR>", { desc = "Toggle [H]idden characters visibility" })
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<leader>rt', function ()
  require("neotest").run.run({ suite = false, strategy = "dap"})
end, { desc = "[R]un [T]est"})

-- Navigate definitions in new buffers
vim.keymap.set("n", "gD", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", { desc = 'Go To Definition in a new Tab'})
vim.keymap.set("n", "gT", "<cmd>vsplit | lua vim.lsp.buf.type_definition()<CR>", { desc = 'Go To Definition in a new Tab'})

-- Terminal
local exitTerm = function ()
  vim.cmd(":ToggleTerm");
end
vim.keymap.set({"t", "n", "i", "v"}, "<ESC><ESC>", exitTerm, {desc = "Toggle Terminal"})
-- vim.keymap.set("t", "<C-C>", "<C-\\><C-N>", { desc = "exit from term mode"})
vim.keymap.set("n", "<leader>build", "<CMD>TermExec cmd='make build'<CR>", {desc = "run `make build` cmd in the terminal"})

-- Tests
vim.keymap.set("n", "<leader>tt", function ()
  require("neotest").run.run()
end , {desc="run nearest [T]es[T]"})

vim.keymap.set("n", "<leader>tdb", function ()
  require("neotest").run.run({strategy="dap"})
end, {desc="run nearest [T]est in [D]e[B]ug mode"})

vim.keymap.set("n", "<leader>tat", function ()
  require("neotest").run.attach()
end, {desc="[AT]tach to the [T]est"})

vim.keymap.set("n", "<leader>tst", function ()
  require("neotest").run.stop()
end, {desc="[ST]op the [T]est"})
