local M = {}

M.check = function ()
  vim.health.start("weather report")

  if vim.fn.executable("curl") == 0 then
	vim.health.error("curl not found")
	return
  end

  local curl_version_results = vim.system({ "curl", "--version" }, { text = true }):wait()
  if curl_version_results.code ~= 0 then
	vim.health.error("failed to retrieve curl's version", curl_version_results.stderr)
	return
  end
  local version = vim.version.parse(vim.split(curl_version_results.stdout or "", " ")[2])
  if version ~= nil and version.major ~= 8 then
	vim.health.error("curl must be 8.x.x, but got "..tostring(version))
  end

  local wttr_results = vim.system({ "curl", "wttr.in" }):wait()
  if wttr_results.code ~= 0 then
	vim.health.error("wttr.in is not accessible")
  end
end

return M
