-- absolute numer in INSERT mode, relative in other modes
vim.api.nvim_create_augroup("LineNumbersToggle", { clear = true })

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  group = "LineNumbersToggle",
  callback = function ()
	vim.opt.relativenumber = false
  end,
  desc = "set absolute line numbers when entering Insert mode",
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '*.go' },
  callback = function() vim.treesitter.start() end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  group = "LineNumbersToggle",
  callback = function ()
	vim.opt.relativenumber = true
  end,
  desc = "set relative line numbers when leaving Insert mode",
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '',
  command = ":%s/\\s\\+$//e",
  desc = "remove whitespace on save"
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '',
  command = 'set fo-=c fo-=r fo-=o',
  desc = "don't auto commenting new lines"
})

vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
	local mark = vim.api.nvim_buf_get_mark(0, '"')
	local lcount = vim.api.nvim_buf_line_count(0)
	if mark[1] > 0 and mark[1] <= lcount then
	  pcall(vim.api.nvim_win_set_cursor, 0, mark)
	end
  end,
  desc = "go to last loc when opening a buffer",
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function ()
	vim.highlight.on_yank({timeout=300})
  end
})

vim.api.nvim_create_autocmd("TermLeave", {
  desc = "Reload buffers when leaving terminal",
  pattern = "*",
  callback = function()
	vim.cmd.checktime()
  end,
})

vim.api.nvim_create_autocmd({ "TermEnter", "BufWinEnter" }, {
  desc = "Enter insert mode automatically when entering a terminal",
  pattern = "term://*",
  callback = function()
	if vim.bo.buftype == "terminal" and vim.fn.mode() == "n" then
	  -- if it's a non-active terminal do nothing
	  if vim.fn.win_gettype() ~= "" then return end
	  vim.cmd("startinsert")
	end
  end,
})

