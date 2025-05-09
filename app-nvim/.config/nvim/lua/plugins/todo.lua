-- Stuff to do with todos

return {
  -- highlight and list todos 
  {"folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- from https://github.com/folke/todo-comments.nvim/issues/195
      search = {
        pattern = [[\b(KEYWORDS)( *\([[:alnum:]-]+\) *)?:]],
      },
      highlight = {
        pattern = [[<(KEYWORDS)( *\([[:alnum:]-]+\) *)?:]],
      }
    }
  }
}
