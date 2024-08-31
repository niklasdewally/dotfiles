-- vim: cc=80

-- Highlight, edit, and navigate code with treesitter.
--
-- Highlighting by treesitter itself, selection stuff with 
-- treesitter-text-subjects:
-- https://github.com/RRethy/nvim-treesitter-textsubjects
-- (see kickstart.nvim)

return {
  {'nvim-treesitter/nvim-treesitter',
    -- on first install, also install all the treesitter parsers
    build = ':TSUpdate',
    dependencies = {'RRethy/nvim-treesitter-textsubjects'},
    main = 'nvim-treesitter.configs',
    opts = {
      sync_install = true, -- install parsers synchronously
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      textsubjects = {
        enable = true,
        prev_selection = ',', -- (Optional) keymap to select the previous selection
        keymaps = {
          ['.'] = 'textsubjects-smart',
          [';'] = 'textsubjects-container-outer',
          ['i;'] = { 'textsubjects-container-inner', desc = "Select inside containers (classes, functions, etc.)" },
        },
      },
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
        'vim'
      }
    },
  },
}

