-- Key binding groups

return {
{"folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {},
  config = function(opts,_)
      local wk = require("which-key")
      wk.setup(opts)
      -- Define keybind groups
      wk.register({
        ["<leader>"] = {
          s = { name = "+[s]earch"},
          h = { name = "+Git [h]unk"},
          l = { name = "+[l]sp"},
          S = {name = "+[S]nippets"},
          q = {name="+[q]uarto"}
        }
      })
    end
  
}

}
