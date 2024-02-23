-- vim:foldmethod=marker cc=80
--
-- init.lua, 2024-01 edition.
--
-- * move from packer to lazy.nvim.
-- * place plugin groups into multiple files!
-- * lean things down a bit :)
--
-- Bits shamelessly taken from kickstart config:
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
--
-- Also useful is:
-- https://www.barbarianmeetscoding.com/notes/neovim-lazyvim/#lazynvim

-- PRELUDE

local opt = vim.opt
local g = vim.g

-- must set leaders first so plugins are happy
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- neovide gui 
vim.g.neovide_cursor_animation_length = 0

-- Install lazy.nvim plugin manager {{{
-- from kickstart.nvim
--
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
--- }}}
--
-- Any files in lua/plugin/*.lua are merged into the main lazy.nvim
-- plugin spec table. Inside each file should be
-- `return { {'plugin1',...}, {'plugin2',...} }`
--
--1: https://github.com/folke/lazy.nvim#-plugin-spec
require("lazy").setup("plugins")

opt.rnu = true
opt.nu = true

opt.autoindent = true
opt.expandtab = true
opt.smartindent = true

opt.tabstop = 2
opt.shiftwidth = 2


-- Configure verbosity of diganostic stuff
vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
    source = "if_many",
  },
  underline    = true,
  signs        = true
})

vim.keymap.set('n', 'g?', function() vim.diagnostic.open_float({}) end, { silent = true })

-- Keep gutter open to stop text wiggling around
vim.opt.signcolumn = "yes"


