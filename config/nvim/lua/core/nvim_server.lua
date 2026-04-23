local function get_clients()
  return vim.iter(vim.api.nvim_list_chans())
  :filter(function(o) return not not o.client end)
  :map(function(o)
    return ('%s:%s'):format(
      vim.tbl_get(o, 'client', 'name'),
      vim.tbl_get(o, 'client', 'attributes', 'pid')
    )
  end):totable()
end

local function nvim_info()
  return {
    socket = vim.v.servername,
    clients = get_clients(),
  }
end

M = {
  nvim_info = nvim_info,
  get_clients = get_clients,
}

return M
