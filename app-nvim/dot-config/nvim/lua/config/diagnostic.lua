-- Configuration for diagnostics and linters. 
--

-- See also: 
--
--  + ../../ftplugin/after/<lang>.lua: for filetype specific configuration
--
--  + keymaps.lua:          defines the gK toggle for virtual lines
--  + lsp.lua:              defines the configuration of langauge servers (which also provide 
--                          diagnostics)
--  + ../plugins/lint.lua:  installs nvim-lint, the plugin that provides the linter configs that I 
--                          use.

-- Setup linters
local lint = require('lint')

lint.linters_by_ft = {
  sh = {'shellcheck'},
  bash = {'shellcheck'},
}

-- Lint on save and file open
--
-- Snippet from nvim-lint documentation
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
  callback = function()

    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype
    require("lint").try_lint()
  end,
})

-- vim: cc=100
