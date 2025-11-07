local terminal_grp = vim.api.nvim_create_augroup("TerminalLocalOptions", {})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = terminal_grp,
  pattern = { "*" },
  callback = function(event)
    vim.opt.cursorline = false
    local code_term_esc = vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, true, true)
    for _, key in ipairs({ "h", "j", "k", "l" }) do
      vim.keymap.set("t", "<C-" .. key .. ">", function()
        local code_dir = vim.api.nvim_replace_termcodes("<C-" .. key .. ">", true, true, true)
        vim.api.nvim_feedkeys(code_term_esc .. code_dir, "t", true)
      end, { noremap = true })
    end
    if vim.bo.filetype == "" then
      vim.api.nvim_set_option_value("filetype", "terminal", { buf = event.buf })
      if vim.g.catgoose_terminal_enable_startinsert == 1 then
        vim.cmd.startinsert()
      end
    end
  end,
})

vim.api.nvim_create_autocmd({ "WinEnter" }, {
  group = terminal_grp,
  pattern = { "*" },
  callback = function()
    if vim.bo.filetype == "terminal" and vim.g.catgoose_terminal_enable_startinsert then
      vim.cmd.startinsert()
    end
  end,
})
-- vim.api.nvim_create_autocmd("TermLeave", {
--   desc = "Reload buffers when leaving terminal",
--   pattern = "*",
--   callback = function()
--     vim.cmd.checktime()
--   end,
-- })
--
-- vim.api.nvim_create_autocmd({ "TermEnter", "BufWinEnter" }, {
--   desc = "Enter insert mode automatically when entering a terminal",
--   pattern = "term://*",
--   callback = function()
--     if vim.bo.buftype == "terminal" and vim.fn.mode() == "n" then
--       -- if it's a non-active terminal do nothing
--       if vim.fn.win_gettype() ~= "" then return end
--       vim.cmd("startinsert")
--     end
--   end,
-- })
