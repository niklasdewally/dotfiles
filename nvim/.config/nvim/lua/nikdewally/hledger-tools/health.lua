local M = {}

M.check = function()
  vim.health.start("nikdewally.hledger-tools")

  local have_nvim_treesitter,_ = pcall(require,"nvim-treesitter")

  if not have_nvim_treesitter then
    vim.health.error("nvim-treesitter not installed")
    return;
  end

  vim.health.ok("nvim-treesitter installed")

  -- check that we have the #kind-eq? predicate provided by nvim-treesitter

  local predicates = vim.treesitter.query.list_predicates()

  local has_predicate = false
  for _, predicate in pairs(predicates) do
    if predicate == "kind-eq?" then
      has_predicate = true
      break
    end
  end

  if has_predicate then
    vim.health.ok("treesitter predicate #kind-eq? provided by nvim-treesitter installed.")
  else
    vim.health.error("missing treesitter predicate #kind-eq? provided by nvim-treesitter.")
  end

  -- check that ledger grammar is installed
  local ledger_ts_installed = false
  local installed_languages = require('nvim-treesitter').get_installed()
  for _, lang in pairs(installed_languages) do
    if lang == "ledger" then
      ledger_ts_installed = true
      break
    end
  end

  if ledger_ts_installed then
    vim.health.ok("ledger treesitter grammar installed.")
  else
    vim.health.error("ledger treesitter grammar not installed.")
  end
end


return M
