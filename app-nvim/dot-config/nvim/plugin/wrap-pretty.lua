-- commands to enable and disable ft=wrap-pretty for nicer text wrapping
-- TODO command to disable it

vim.api.nvim_create_user_command('EnableWrap',':lua vim.b.wrap_old_filetype = vim.opt_local.filetype:get(); vim.opt_local.filetype = vim.opt_local.filetype:get() .. ".wrap-pretty"',{})
vim.api.nvim_create_user_command('DisableWrap',':lua vim.opt_local.filetype = vim.b.wrap_old_filetype',{})

