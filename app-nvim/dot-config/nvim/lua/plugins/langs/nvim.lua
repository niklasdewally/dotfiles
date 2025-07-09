-- nvim development
 
return {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        "~/.config/nvim/lua/"

      }
    }
}
