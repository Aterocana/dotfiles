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
vim.keymap.set("n", "<Leader>m", ":Telescope marks<CR>", { desc = "show marks" })

-- Navigate through windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Down Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Up Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Right Window" })

-- Windows Managing
vim.keymap.set("n", "<leader>|", ":vsplit<CR>", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>-", ":split<CR>", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>wk", "<CMD>resize +20<CR>", { desc = "Resize [w]indow UP" })
vim.keymap.set("n", "<leader>wj", "<CMD>resize -20<CR>", { desc = "Resize [w]indow DOWN" })
vim.keymap.set("n", "<leader>wh", "<CMD>vertical resize +10<CR>", { desc = "Resize [w]indow LEFT" })
vim.keymap.set("n", "<leader>wl", "<CMD>vertical resize -10<CR>", { desc = "Resize [w]indow RIGHT" })

-- Substitution
vim.keymap.set("n", "<leader>sub", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "[S]ubstitution on current word"})

-- open Lazy Packet Manager UI
vim.keymap.set("n", "<leader>L", vim.cmd.Lazy, { desc = "Open [L]azyNVim Manager"})

-- interact with system clipboard
vim.keymap.set("v", "<leader>y", '"+y', { desc = "[Y]ank into system clipboard"})
vim.keymap.set({"n", "x"}, "<leader>yy", '"+yy', { desc = "[Y]ank line into system clipboard"})
-- vim.keymap.set({"n", "x"}, "<leader>p", '"+p', { desc = "[P]aste from system clipboard after current position"})
-- vim.keymap.set({"n", "x"}, "<leader>P", '"+P', { desc = "[P]aste from system clipboard before current position"})

-- toggle debugger
vim.keymap.set("n", "<leader>db", '<CMD>DBUIToggle<CR>', {desc = "Toggle [D]e[B]ug view"})

-- toggle hidden characters
vim.keymap.set("n", "<leader>h", ":set list!<CR>", { desc = "Toggle [H]idden characters visibility" })
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>ti', require('core.inlay_hints').toggle_hint, {desc = "[T]oggle [I]nlay_hints"})

-- Terminal
local exitTerm = function ()
  vim.cmd(":ToggleTerm");
end
vim.keymap.set({"t", "n", "i", "v"}, "<M-t>", exitTerm, {desc = "Toggle Terminal"})
-- Allow exiting insert mode in terminal by hitting <ESC>
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Feed ESC in terminal mode using <C-\>
vim.keymap.set("t", "<C-\\>", function()
  vim.api.nvim_feedkeys(
	vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
	"n",
	false
  )
end)
vim.keymap.set("n", "<leader>build", "<CMD>TermExec cmd='make build'<CR>", {desc = "run `make build` cmd in the terminal"})

-- Tests
vim.keymap.set("n", "<Leader>tt", function ()
  require("neotest").run.run()
end , {desc="run nearest [T]es[T]"})

vim.keymap.set("n", "<Leader>db", function ()
  require("neotest").run.run({strategy="dap"})
end, {desc="run nearest [T]est in [D]e[B]ug mode"})

vim.keymap.set("n", "<Leader>st", function ()
  require("neotest").run.stop()
end, {desc="[ST]op the [T]est"})

-- git cmds
vim.keymap.set("n", "<Leader><Leader>do", ":DiffviewOpen <CR>", {desc = "Git [D]iff view [O]pen"})
vim.keymap.set("n", "<Leader><Leader>dc", ":DiffviewClose <CR>", {desc = "Git [D]iff view [C]lose"})

-- JSON Visual Mode
vim.keymap.set("v", "<SPACE>jb", ":'<,'>!jq<CR>", {desc = "[J]SON [B]eatify the selection"})
vim.keymap.set("v", "<SPACE>jug", ":'<,'>!jq -c<CR>", {desc = "[J]SON [UG]lify (minify) the selection"})
vim.keymap.set("v", "<SPACE>jes", ":'<,'>!jq -c<CR>gv !jq -R<CR>", {desc = "[J]SON [ES]scape the file (it first minifies it)"})
vim.keymap.set("v", "<SPACE>jun", ":'<,'>!jq -r<CR>", {desc = "[J]SON [UN]escape the selection"})

vim.keymap.set("n", "<leader>C", function ()
  vim.ui.input({}, function(c)
	if c and c~="" then
	  vim.cmd("noswapfile vnew")
	  vim.bo.buftype = "nofile"
	  vim.bo.bufhidden = "wipe"
	  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(c))
	end
  end)
end, {desc = "run a command and send its output to a scratch buffer"})

vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition)
vim.keymap.set("n", "<leader>di", "<cmd>Telescope diagnostics<cr>")
vim.keymap.set("n", "<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>")

vim.keymap.set("i", "<C-Space>", vim.lsp.buf.completion)
vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help)
