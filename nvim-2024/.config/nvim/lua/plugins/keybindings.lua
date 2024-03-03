-- Key binding groups

return {
{"folke/which-key.nvim",
  event = "VimEnter",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {},
  config = function(opts,_)
      local wk = require("which-key")
      wk.setup(opts)
      -- Define keybind groups
      -- idk why which_key_ignore works here, but it is necessary to
      -- make the LSP keybind's that bind on buffer work.
      -- from kickstart.nvim
      wk.register({
          ['<leader>c'] = {name = '[c]ode',_="which_key_ignore"},
          ['<leader>d'] = {name = '[d]ocument',_="which_key_ignore"},
          ['<leader>h'] = { name = "Git [h]unk",_="which_key_ignore"},
          ['<leader>l'] = { name = "[l]ist",_="which_key_ignore"},
          ['<leader>r'] = {name="[r]ename",_="which_key_ignore"},
          ['<leader>s'] = { name = "[s]earch",_="which_key_ignore"},
          ['<leader>S'] = {name = "[S]nippets",_="which_key_ignore"},
          ['<leader>q'] = {name="[q]uarto",_="which_key_ignore"},
          ['<leader>w'] = {name="[w]orkspace",_="which_key_ignore"},
          ['gc'] = {name="[c]ommentary",_="which_key_ignore"}
      })
    end
}
}
