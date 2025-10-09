-- Installation of language specific plugins
--
-- Locations of language plugin configs
-- ------------------------------------
--
-- A generally useful discussion on where to place plugin settings:
-- https://ejmastnak.com/tutorials/vim-latex/vimtex/#configuration
--
-- * LSP setup can be found in plugin/21_lsp.lua
--
-- * Treesitter setup can be found in plugin/20_treesitter.lua.
--
-- Global (vim.g) settings should be placed in plugin/ not ftplugin/, 
-- after/plugin, or plugin so that:
--
--  1. they are loaded before the plugin is
--  2. they are only loaded once. 
--
--  If global settings are placed in ftplugin instead, they will be loaded once
--  per buffer. ftplugin should contain buffer specific settings / keymaps we
--  only want to see in buffers of that language.

vim.pack.add({
  -- Essence / Essence Prime
  "https://github.com/niklasdewally/conjure.nvim",

  -- Haskell 
  {src = 'https://github.com/mrcjkb/haskell-tools.nvim'},

  -- Rust
  {src = 'https://github.com/mrcjkb/rustaceanvim'},

  -- Latex
  'https://github.com/lervag/vimtex',

  -- Nand2tetris syntax highlighting
  'https://github.com/sevko/vim-nand2tetris-syntax',

  -- quarto, plus dependencies
  "https://github.com/jmbuhr/otter.nvim",
  "https://github.com/quarto-dev/quarto-nvim",
})

-- Haskell global configuration

-- Rust global configuration

-- Vimtex global configuration
vim.g.vimtex_view_method = 'skim'
