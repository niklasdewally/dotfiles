-- git related plugins

loadPlugins({
  -- :Git and lots of good stuff
  "https://github.com/tpope/vim-fugitive",

  -- Resolve merge conflicts as a diff 
  "https://github.com/whiteinge/diffconflicts",

  -- add git diff signs to the gutter
  "https://github.com/lewis6991/gitsigns.nvim"
})

require('gitsigns').setup()
