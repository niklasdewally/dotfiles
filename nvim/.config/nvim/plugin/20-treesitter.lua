-- Treesitter

-- FIXME: currently todo highlighting only works when in a file with a treesitter grammar

loadPlugins({
  {src = "https://github.com/nvim-treesitter/nvim-treesitter",version = "main"},
})

-- languages to enable treesitter with
local treesitter_languages = {
  'bash',
  'c',
  'comment',
  'cpp',
  'gitcommit',
  'javascript',
  'ledger',
  'lua',
  'python',
  'rust',
  'typescript'
}


-- TODO: currently this blocks, fix!

-- if any languages above are not installed, install them

-- use treesitter for the languages above 
vim.api.nvim_create_autocmd('FileType', {
  pattern = treesitter_languages,
  callback = function(ev)
      local lang = ev.match
      -- install parser if not installed
      local installed_languages = require('nvim-treesitter').get_installed()
      if not installed_languages[lang] then
        require("nvim-treesitter").install({lang}):wait(300000)
      end

      -- syntax highlighting, provided by Neovim
      vim.treesitter.start(ev.buf)
      vim.bo[ev.buf].syntax = 'ON'  -- reenable legacy syntax highlighting, required for treesitter.

      -- folds, provided by Neovim
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

      -- indentation, provided by nvim-treesitter
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
})
