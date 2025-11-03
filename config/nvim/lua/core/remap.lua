--true Navigation and Searching
vim.keymap.set("n", "<leader>pv", vim.cmd.Oil, { desc = "Open file manager in current directory" })

-- Undo tree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle [U]ndotree buffer" })

-- Visual mode: use J and K to move selected portion down or up.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc = "Move selected portion down"})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc = "Move selected portion up"})

-- Visual mode: indent selection right or left
vim.keymap.set("v", "<", "<gv", {desc= "indent selection to the left"})
vim.keymap.set("v", ">", ">gv", {desc= "indent selection to the right"})

-- Editing words
vim.keymap.set("n", "<leader>,", "<cmd>norm A,<CR>", { desc = "Append comma" })
vim.keymap.set("n", "<leader>;", "<cmd>norm A;<CR>", { desc = "Append semicolon" })

-- Wrap text
vim.keymap.set("v", '<leader>"', [[c"<c-r>""<esc>]], { desc = 'Wrap text in quotes ""' })
vim.keymap.set("n", '<leader>"', [[ciw"<c-r>""<esc>]], { desc = 'Wrap text in quotes ""' })
vim.keymap.set("v", "<leader>(", [[c(<c-r>")<esc>]], { desc = "Wrap text in brackets ()" })
vim.keymap.set("n", "<leader>(", [[ciw(<c-r>")<esc>]], { desc = "Wrap text in brackets ()" })
vim.keymap.set("v", "<leader>{", [[c{<c-r>"}<esc>]], { desc = "Wrap text in curly braces {}" })
vim.keymap.set("n", "<leader>{", [[ciw{<c-r>"}<esc>]], { desc = "Wrap text in curly braces {}" })
vim.keymap.set("v", "<leader>[", [[c[<c-r>"]<esc>]], { desc = "Wrap text in square braces []" })
vim.keymap.set("n", "<leader>[", [[ciw[<c-r>"]<esc>]], { desc = "Wrap text in square braces []" })
vim.keymap.set("v", "<leader>`", [[c`<c-r>``<esc>]], { desc = "Wrap text in backticks ``" })

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
vim.keymap.set("n", "<leader>yy", '"+yy', { desc = "[Y]ank line into system clipboard"})

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

-- Tests
vim.keymap.set("n", "<Leader>tt", function()
  require("neotest").run.run()
end, {desc="run nearest [T]es[T]"})

vim.keymap.set("n", "<Leader>db", function ()
  require("neotest").run.run({strategy="dap"})
end, {desc="run nearest [T]est in [D]e[B]ug mode"})

vim.keymap.set("n", "<Leader>ts", "<cmd>Neotest summary<cr>", {desc="Toggle [T]est [S]mmary"})

-- git cmds
vim.keymap.set("n", "<Leader><Leader>do", ":DiffviewOpen <CR>", {desc = "Git [D]iff view [O]pen"})
vim.keymap.set("n", "<Leader><Leader>dc", ":DiffviewClose <CR>", {desc = "Git [D]iff view [C]lose"})
-- vim.keymap.set("n", "<Leader>u", ":Atone toggle<CR>", { desc = "Toggle Undo Tree" })
vim.keymap.set("n", "<Leader>u", ":Atone toggle <CR> :Atone focus<CR>", { desc = "Toggle Undo Tree" })

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

-- Navigate definitions in new buffers
vim.keymap.set("n", "gD", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", { desc = 'Go To Definition in a new Tab'})
vim.keymap.set("n", "gT", "<cmd>vsplit | lua vim.lsp.buf.type_definition()<CR>", { desc = 'Go To Definition in a new Tab'})
-- vim.keymap.set("n", "<leader>di", "<cmd>Telescope diagnostics<cr>")
-- vim.keymap.set("n", "<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>")

vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help)

-- code companion
vim.keymap.set("n", "<leader>ccc", "<cmd>CodeCompanionChat<cr>", { desc = "Open [C]ode [C]ompanion [C]hat"})
vim.keymap.set("n", "<leader>cca", "<cmd>CodeCompanionAction<cr>", { desc = "Open [C]ode [C]ompanion [A]ction"})
