-- function which assign vim autocommand `command` when a buffer (matching provided `pattern`) is written,
-- writing output in `output_bufnr`.
local attach_to_buffer = function(output_bufnr, pattern, command)
	-- assign autocommand to "BufWritePost" event
	vim.api.nvim_create_autocmd("BufWritePost", {
		-- create an auto group which assign autocommand to.
		group = vim.api.nvim_create_augroup("core_autocmds", {}),
		pattern = pattern,
		callback = function ()
			local append_data = function (_, data)
				if data then
					vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
				end
			end

			vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, { "output:" })
			vim.fn.jobstart(command, {
				stdout_buffered = true,
				on_stdout = append_data,
				on_stdett = append_data,
			})
		end
	})
end

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
