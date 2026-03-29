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

  if vim.fn.executable("shellcheck")
  then
    vim.health.ok("shellcheck: found, using as bash linter.")
  else
    vim.health.warn("shellcheck: not found.", {"Install shellcheck to enable bash linting."})
  end

  if vim.fn.executable("hledger")
  then
    vim.health.ok("hledger: found, using as ledger linter.")
  else
    vim.health.warn("hledger: not found.", {"Install hledger to enable ledger linting."})
  end

end

return M
