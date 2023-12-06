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
  },

  {'RRethy/nvim-treesitter-textsubjects',
    dependencies = {'nvim-treesitter/nvim-treesitter'},
    config= function(_,_)
      require('nvim-treesitter.configs').setup {
        textsubjects = {
          enable = true,
          prev_selection = ',', -- (Optional) keymap to select the previous selection
          keymaps = {
            ['.'] = 'textsubjects-smart',
            [';'] = 'textsubjects-container-outer',
            ['i;'] = { 'textsubjects-container-inner', desc = "Select inside containers (classes, functions, etc.)" },
          },
        }
      }
    end
  }

}

