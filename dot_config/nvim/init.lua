-- vim:foldmethod=marker
-- AUTOINSTALL PACKER {{{
-- Adapted from https://github.com/wbthomason/packer.nvim
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

ensure_packer()
-- }}}
-- PLUGINS {{{
require('packer').startup(function(use)
  -- LARGELY COPIED FROM .VIMRC

  use 'wbthomason/packer.nvim'

  -- Aesthetics
  use "ellisonleao/gruvbox.nvim"
  use "airblade/vim-gitgutter" -- show git diff info in airline

  -- Navigation
  use "preservim/nerdtree" -- file browsing

  -- TODO: telescope or fzf?

  -- REPL Integration
  use 'jpalardy/vim-slime' -- REPL Integration

  -- Markdown Writing
  use 'vim-pandoc/vim-pandoc'
  use 'vim-pandoc/vim-pandoc-syntax'
  use 'dhruvasagar/vim-table-mode'

  --  Racket / Scheme
  -- See: https://docs.racket-lang.org/guide/Vim.html
  use 'benknoble/vim-racket' -- basic language plugin
  use 'kien/rainbow_parentheses.vim'

  -- use this one for emacs-paredit like functionality (auto close brackets, plus
  -- some other vim keybindings!) - it also supports REPL stuff, but not for
  -- racket!
  use 'kovisoft/slimv'

  -- HTML / CSS
  use 'gregsexton/matchtag' -- match HTML tags

  -- Haskell
  use 'neovimhaskell/haskell-vim'
  use 'monkoose/fzf-hoogle.vim'

  -- Automatically set up your configuration after cloning packer.nvim
  require('packer').sync()
end)
-- }}}
-- EDITOR: COLOUR SCHEME {{{
vim.opt.background = "dark"
vim.cmd([[ colorscheme gruvbox ]])
-- }}}
