-- use shell format  to format
vim.bo.formatexpr = nil

-- lua/config/health.lua adds this check to :checkhealth
if vim.fn.executable("shfmt") then
  vim.bo.formatprg = "shfmt -"
end

if vim.fn.executable("shellcheck") then
  local lint = require("lint")
  -- customise shellcheck to add -x flag, allowing it to follow sources
  local shellcheck = require("lint").linters.shellcheck
  table.insert(shellcheck.args,0,"-x")
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
      lint.try_lint("shellcheck")
    end,
  })
end
