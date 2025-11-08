-- healthchecks :h health

local M = {}

M.check = function()
  vim.health.start("External tools (linters, formatters, etc)")
  if vim.fn.executable("shfmt")
  then
    vim.health.ok("shfmt: found, using as bash formatter.")
  else
    vim.health.warn("shfmt: not found.", {"Install shfmt to enable bash formatting."})
  end

end

return M
