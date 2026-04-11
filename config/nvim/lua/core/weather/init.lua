local M = {}

local function url_encode(s)
  s = s:gsub("\n", "\r\n")
  s = s:gsub("([^%w _%%%-%.~])", function(c)
    return string.format("%%%02X", string.byte(c))
  end)
  s = s:gsub(" ", "+")
  return s
end

function M.fetch(opts)
  opts = opts or {}

  local location = opts.location or vim.fn.input("Location: ")

  local results = vim.system({ "curl", "wttr.in/" .. url_encode(location) .. "?format=j1" }):wait()
  if results.code ~= 0 then
    vim.notify("failed to retrieve temperature: " .. (results.stderr or ""), vim.log.levels.ERROR)
    return nil
  end

  local data = vim.json.decode(results.stdout or "", { array = true, object = true })

  return data
end

function M.print(opts)
  opts = opts or {}

  local location = opts.location or vim.fn.input("Location: ")

  local temperature = M.fetch({ location = location })
  if not temperature then return end
  local cc = temperature.current_condition[1]
  local msg = ("It's currently %s°C %s"):format(
    cc.temp_C,
    location and ("in " .. location) or "for you"
  )
  vim.notify(msg)
end

vim.api.nvim_create_user_command("Temperature", function(opts)
  local location
  if string.len(opts.args) > 0 then
    location = opts.args
  end

  M.print({ location = location })
end, {
nargs = "*",
desc = "Check the temperature",
})

return M
