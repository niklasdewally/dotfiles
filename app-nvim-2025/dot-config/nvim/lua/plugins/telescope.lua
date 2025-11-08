-- telescope for searching

return {
  -- nicer quickfix box
  {'yorickpeterse/nvim-pqf'},
  {'nvim-telescope/telescope.nvim', 
    -- FIXME: update to a release branch for nvim v0.11 once one is made
    commit = 'a4ed82509cecc56df1c7138920a1aeaf246c0ac5',

    dependencies = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },

    config = function(_,_)
      require('telescope').setup({
        pickers = {
          colorscheme = {
            enable_preview = true
          }},
        defaults = { 
          mappings = { 
            i = { 
              ['C-h'] = "which_key", 
              ['C-q'] = "smart_send_to_qflist",
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            }}}})

      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')
    end
  },
}
