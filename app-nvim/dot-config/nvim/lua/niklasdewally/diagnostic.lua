-- random helper functions for diagnostics
local M = {}


--- Gets a list of all buffers containing diagnostics of the given severity or above.
---
--- When loading diagnostics from a lsp server, it creates a new unlisted buffer for each file with a diagnostic.
--- The buffer numbers can be converted back into filenames using [`vim.api.nvim_buf_get_name`].
---
--- @param severity? vim.diagnostic.SeverityFilter The severity of the diagnostics to get.
--- @returns a table indexed by buffer id, containing the number of diagnostics in that buffer.
function M.get_files_with_diagnostics(severity)
  local diagnostics = vim.diagnostic.get(nil, { severity = severity })
  if not diagnostics then
    return {}
  end

  -- map of bufnr -> # of diagnostics
  local bufs = {}

  -- for each diagnostic, if it has a buffer, add it to our set
  for _, d in pairs(diagnostics) do
    if d.bufnr then
      if not bufs[d.bufnr] then
        bufs[d.bufnr] = (bufs[d.bufnr] or 0) + 1
      end
    end
  end

  return bufs
end

--- Populates the quickfix list with all files containing errors.
function M.setqf_files_with_errors(open_quickfix)
  local buffers = M.get_files_with_diagnostics(vim.diagnostic.severity.ERROR)

  local items = {}

  for bufnr, numdiagnostics in pairs(buffers) do
    table.insert(items, {
      bufnr = bufnr,
      text = "contains " .. numdiagnostics .. " errors."
    })
  end

  local what = {
    title = "Files with errors",
    items = items
  }
  vim.fn.setqflist({}, 'r', what)
  if open_quickfix then
    vim.cmd("copen")
  end
end

--- Populates the quickfix list with all files containing errors or warnings.
function M.setqf_files_with_warnings(open_quickfix)
  local buffers_with_errors = M.get_files_with_diagnostics(vim.diagnostic.severity.ERROR)
  local buffers_with_warnings = M.get_files_with_diagnostics(vim.diagnostic.severity.WARN)

  -- map from bufnr to { warnings = ..., errors = ... }
  local buffers = {}

  for bufnr, num_errors in pairs(buffers_with_errors) do
    buffers[bufnr] = { errors = num_errors, warnings = 0 }
  end

  for bufnr, num_warnings in pairs(buffers_with_warnings) do
    if buffers[bufnr] then
      buffers[bufnr].warnings = num_warnings
    else
      buffers[bufnr] = { errors = 0, warnings = num_warnings }
    end
  end

  -- convert into quickfix-list items 
  local items = {}

  for bufnr, info in pairs(buffers) do
    local errors = info.errors;
    local warnings = info.warnings;

    local sign = errors > 0 and "E" or "W"

    table.insert(items, {
      bufnr = bufnr,
      sign = sign,
      text = "contains " .. errors .. " errors and " .. warnings .. " warnings."
    })
  end

  local what = {
    title = "Files with errors or warnings",
    items = items
  }
  vim.fn.setqflist({}, 'r', what)
  if open_quickfix then
    vim.cmd("copen")
  end
end

return M
