-- use shell format  to format
vim.bo.formatexpr = nil

-- lua/config/health.lua adds this check to :checkhealth
if vim.fn.executable("shfmt") then
vim.bo.formatprg = "shfmt -"
end
