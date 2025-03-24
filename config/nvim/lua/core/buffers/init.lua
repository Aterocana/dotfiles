local api = vim.api
local BUFNAME = "opened_buffers"

local get_buf = function ()
  local buf = vim.fn.bufnr(BUFNAME)
  if buf ~= 1 then
	-- Check if it's currently visible in a window
	for _, win in ipairs(vim.api.nvim_list_wins()) do
	  if vim.api.nvim_win_get_buf(win) == buf then
		-- If open, close the window
		vim.api.nvim_win_close(win, true)
		return buf
	  end
	end
  end
  buf = api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, BUFNAME)
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
  return buf
end

local starts_with = function (s, start)
  return string.match(s, "^"..start)
end

local M = {}

M.get_open_buffers = function ()
  local result = {}
  local bufs = api.nvim_list_bufs()
  for i=1, #bufs do
	local name = api.nvim_buf_get_name(bufs[i])
	if name ~= "" and name ~= BUFNAME and not starts_with(name,  "oil://") then
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
  local buf_nr = get_buf()
  local strs = {}
  for _, buf in ipairs(bufs) do
	table.insert(strs, "<"..buf.nr.."> "..buf.name)
  end
  vim.api.nvim_set_option_value("modifiable", true, { buf = buf_nr })
  api.nvim_buf_set_lines(
	buf_nr, 0, -1, false,
	strs
  )
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf_nr })
  api.nvim_open_win(buf_nr, false, {
	split = 'left',
	win = 0
	--relative='win', row=100, col=300, width=200, height=40
  })
end

return M
