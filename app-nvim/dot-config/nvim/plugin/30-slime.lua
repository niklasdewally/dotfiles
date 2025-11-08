-- slime: send code to a tmux tab by C-c C-c
--
-- reconfigure using C-c v (memomic: v = variables)

addPlugs({"https://github.com/jpalardy/vim-slime"})

vim.g.slime_bracketed_paste = 1
vim.g.slime_target = "tmux"
vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}" }
