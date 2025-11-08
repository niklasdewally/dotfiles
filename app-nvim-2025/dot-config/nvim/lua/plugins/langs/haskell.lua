-- use plugin for haskell instead of just the lsp server

--  language config that is not plugins can be found in after/ftplugin/haskell.lua

return {
  {
    'mrcjkb/haskell-tools.nvim',
    version = '^6', 
    lazy = false, -- This plugin is already lazy
  }
}
