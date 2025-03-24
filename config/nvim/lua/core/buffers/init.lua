local api = vim.api

local M = {}

M.get_open_buffers = function ()
  local result = {}
  local bufs = api.nvim_list_bufs()
  for i=1, #bufs do
	local name =api.nvim_buf_get_name(bufs[i])
	if name ~= "" then
	  table.insert(result, {
		name = name,
		nr = bufs[i]
	  })
	end
  end
  return result
end

M.print_bufs = function ()
  local bufs = M.get_open_buffers()
  local buf_nr = api.nvim_create_buf(true, true)
  local strs = {}
  for _, buf in ipairs(bufs) do
	table.insert(strs, "<"..buf.nr.."> "..buf.name)
  end
  api.nvim_buf_set_lines(
	buf_nr, -1, -1, false,
	strs
  )
  api.nvim_open_win(buf_nr,false, {relative='win', row=100, col=300, width=200, height=40})
end

return M
