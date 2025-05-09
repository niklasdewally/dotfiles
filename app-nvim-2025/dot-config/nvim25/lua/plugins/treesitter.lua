return {
  {"nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",
    dependencies = {'RRethy/nvim-treesitter-textsubjects'},
    main = 'nvim-treesitter.configs',
    opts = {
      auto_install = true,
      -- ensure_installed = {'rust','markdown','markdown_inline','gitcommit'},
      highlight = { enable = true },
      indent = { enable = false },
      incremental_selection = {enable = true}, -- TODO: setup properly
      textsubjects = {
          enable = true,
          prev_selection = ',', -- (Optional) keymap to select the previous selection
          keymaps = {
              -- ['.'] = 'textsubjects-smart', TODO: better keymap for this
              [';'] = 'textsubjects-container-outer',
              ['i;'] = 'textsubjects-container-inner',
          },
      },
    },
  },
}
