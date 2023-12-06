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

opt.rnu = true
opt.nu = true

opt.timeout = true
opt.timeoutlen = 500

opt.autoindent = true
opt.expandtab = true
opt.smartindent = true

opt.tabstop = 2
opt.shiftwidth = 2

require("lazy").setup("plugins")