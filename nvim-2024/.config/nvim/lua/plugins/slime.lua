-- vim: cc=80
-- SLIME: send code to a tmux tab by C-c C-c

return {
  {'jpalardy/vim-slime',
    -- load plugin only when the keybinding is used.
    keys={
      -- Default keybindings as per the README 
      {'<c-c><c-c>'}, -- send paragraph / selection to tmux pane
      {'<c-c>v'}      -- reconfigure vim slime (memomic: v = variables)
    },

    config = function(_,_)
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_target = "tmux"
      vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}" }
    end
  }
}
