-- slime: send code to a tmux tab by C-c C-c
--
-- reconfigure using C-c v (memomic: v = variables)

loadPlugins({"https://github.com/jpalardy/vim-slime"})

vim.g.slime_bracketed_paste = 1
vim.g.slime_target = "tmux"
vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}" }

-- vim.keymap.set('n','<Plug>SlimeParagraphSendAndNext', [[ <Plug>SlimeParagraphSend}<CR> ]])
vim.keymap.set('n','<C-c><C-a>', '<Plug>SlimeParagraphSend}<CR>')
