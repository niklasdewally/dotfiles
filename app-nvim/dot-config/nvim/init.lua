-- vim:foldmethod=marker cc=80
--
-- init.lua, 2025-05 edition.
--
-- Refactor to nvim 0.11
-- 
-- * Remove a lot of plugins now found in core nvim, including lsp, gcc, etc.
-- * Less plugins
-- * Move things into their own files in lua/config (for config), and lua/plugins
--   (for plugin specifications)
--
-- See: 
--   * https://boltless.me/posts/neovim-config-without-plugins-2025/
--   * https://gpanders.com/blog/whats-new-in-neovim-0-11/


-- Set leaders first so plugins are happy
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require('config.plugins')
require('config.options')
require('config.keymaps')
require('config.colourscheme')
require('config.lsp')
require('config.diagnostic')
