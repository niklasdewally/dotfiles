-- wey binding groups

return {
{"folke/which-key.nvim",
  event = "VimEnter",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    },
  config = function(opts,_)
      local wk = require("which-key")

      wk.setup(opts)
      -- Define keybind groups
      wk.add({
          {'<leader>S', group = "[S]nippets"},
          {'<leader>d', group = "[d]ebug / LSP: [d]ocument"},
          {'<leader>w', group = "LSP: [w]orkspace"},
          {'<leader>l', group = "[l]ist"},
          {'<leader>g', group = "[l]ist"},
          {'<leader>h', group = "Git [h]unk"},
          {'<leader>s', group = "[s]earch"},
          {'<leader>T', group = "[T]reesitter"},
          {'<leader><leader>', proxy="<LocalLeader>",group="local"},
          {'gc', desc="[c]ommentary"}
      })
    end


}
}
