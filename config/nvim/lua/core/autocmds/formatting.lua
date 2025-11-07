local format_on_save_grp = vim.api.nvim_create_augroup("LspFormatOnSave", {})

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "remove whitespace on save",
  group = format_on_save_grp,
  callback = function(args)
    local bufnr = args.buf

    -- remove trailing whitespaces
    vim.api.nvim_buf_call(bufnr, function()
      vim.cmd([[%s/\s\+$//e]])
    end)

    -- Skip formatting for Go files, it is handled by goimports or gofmt externally
    if vim.bo[bufnr].filetype == "go" then
      return
    end

    -- Check if any LSP client attached to this buffer supports formatting
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    local can_format = false
    for _, client in ipairs(clients) do
      if client.supports_method("textDocument/formatting") then
        can_format = true
        break
      end
    end

    if can_format then
      -- You can add async = false for sync formatting
      vim.lsp.buf.format({ bufnr = bufnr })
    end
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = "don't auto commenting new lines",
  pattern = '',
  command = 'set fo-=c fo-=r fo-=o',
})

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "go to last loc when opening a buffer",
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= lcount then
      -- pcall(vim.api.nvim_win_set_cursor, 0, mark)
      vim.api.nvim_win_set_cursor(0, mark)
      vim.schedule(function()
        vim.cmd("normal! zz")
      end)
    end
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 300 })
  end
})
