-- Treesitter

-- FIXME: currently todo highlighting only works when in a file with a treesitter grammar

vim.pack.add({{src = "https://github.com/nvim-treesitter/nvim-treesitter",version = "main"}})

-- languages to enable treesitter with
local treesitter_languages = {
  'bash',
  'python',
  'rust',
  'c',
  'cpp',
  'gitcommit',
  'javascript',
  'typescript',
  'comment',
  'lua'
}

local installed_languages = require('nvim-treesitter').get_installed()

-- if any languages above are not installed, install them
for _,lang in pairs(treesitter_languages) do
  if not installed_languages[lang] then
    require("nvim-treesitter").install({lang})
  end
end

-- use treesitter for the languages above 
vim.api.nvim_create_autocmd('FileType', {
  pattern = treesitter_languages,
  callback = function(args)
      -- syntax highlighting, provided by Neovim
      vim.treesitter.start(args.buf)
      vim.bo[args.buf].syntax = 'ON'  -- reenable legacy syntax highlighting, required for treesitter.

      -- folds, provided by Neovim
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

      -- indentation, provided by nvim-treesitter
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
})
