-- use shell format  to format
vim.bo.formatexpr = nil

-- lua/config/health.lua adds this check to :checkhealth
if vim.fn.executable("shfmt") then
  vim.bo.formatprg = "shfmt -"
end

if vim.fn.executable("shellcheck") then
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
      require("lint").try_lint("shellcheck")
    end,
  })
end
