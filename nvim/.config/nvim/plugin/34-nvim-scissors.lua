-- easy creation and editing of snippets 
--
-- this is useful as VSCode / LSP style snippets are in JSON, which is annoying to edit 
-- manually due to having no multi-line support.
--
-- See also:
--
-- * snippet engine: 32-mini.lua
-- * keybinds: 12-keybinds.lua

loadPlugins({"https://github.com/chrisgrieser/nvim-scissors"})

require('scissors').setup({
  snippetDir = vim.fn.stdpath('config') .. '/snippets',
})
