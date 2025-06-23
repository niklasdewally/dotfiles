-- use rustacean nvim plugin instead of just the LSP server

--  language config that is not plugins can be found in after/ftplugin/rust.lua

return {
  {'mrcjkb/rustaceanvim',
  version = '^6', 
  lazy = false, -- This plugin is already lazy
}}

