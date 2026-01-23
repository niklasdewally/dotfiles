-- lua/config/health.lua adds hledger to :checkhealth

if vim.fn.executable("hledger") then
  local lint = require("lint")
  vim.api.nvim_create_autocmd({ "BufWritePost", "BufWinEnter", "InsertLeave"}, {
    callback = function()
      lint.try_lint("hledger")
    end,
  })
end

-- make paragraph markers go to next transaction
vim.keymap.set('n','{',[[?^\d<CR>]])
vim.keymap.set('n','}',[[/^\d<CR>]])
vim.keymap.set('i','<Tab>','<C-r>=ledger#autocomplete_and_align()<CR>')
vim.keymap.set('v','<Tab>',':LedgerAlign<CR>')

vim.keymap.set('n','<LocalLeader>s','gg:TSSort entry<CR><C-O>',{desc = 'sort ledger file by date'})
