-- Use nvim-lint to show diagnostics using linters.
-- (this uses the diagnostics-api, so should be easy to customise if needed)
--
-- See config/diagnostics.lua for configuration details

-- TODO: should this be lazy?

return {
  {
    'mfussenegger/nvim-lint',
    lazy = false, 
  }
}
