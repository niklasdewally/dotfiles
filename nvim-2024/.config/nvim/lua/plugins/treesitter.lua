-- vim: cc=80

-- Highlight, edit, and navigate code with treesitter
-- TODO: treesitter aware navigation stuff with textobjects
-- (see kickstart.nvim)

return {
  {'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },

    build = ':TSUpdate',

    opts = {
      sync_install = false, -- install parsers synchronously
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
      'bash',
      'bibtex',
      'c',
      'cpp',
      'css',
      'diff',
      'dockerfile',
      'dot',
      'gitcommit',
      'haskell',
      "html",
      'javascript',
      'json',
      'lua',
      'make',
      'markdown',
      'markdown_inline',
      'nix',
      'python',
      'r',
      'rust',
      'toml',
      'typescript',
      'vim'}
    }
  }

}

