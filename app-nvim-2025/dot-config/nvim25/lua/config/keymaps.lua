-- Configure custom, global keymaps.
--
-- File-type specific keymaps should be put in after/ftplugin/<filetype>.lua

local wk = require("which-key")
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
-- Quicklist menu setup
vim.keymap.set("n","<leader>lo","<cmd>copen<cr>",{desc = "[l]ist [o]pen"})
vim.keymap.set("n","<leader>lc","<cmd>ccl<cr>",{desc = "[l]ist [c]lose"})
vim.keymap.set("n","<leader>ld",function() vim.diagnostic.setqflist() end,{desc = "[l]ist [d]iagnostics"})

-- also, use [q and ]q from vim-unimpaired, and ctrl-q to send telescope to quickfix

-- TELESCOPE SEARCHES
vim.keymap.set('n', '<leader>s?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>s<space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[s]earch [d]iagnostics' })
vim.keymap.set('n', '<leader>se', function() require('telescope.builtin').diagnostics({["severity"]="error"}) end, { desc = '[s]earch [e]rrors' })
vim.keymap.set('n', '<leader>sf', "<cmd>TodoTelescope keywords=FIX,FIXME,FIXIT,ERROR,WARNING<cr>", { desc = '[s]earch [f]ixmes' })
vim.keymap.set('n', '<leader>sF', require('telescope.builtin').find_files, { desc = '[s]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[s]earch by [g]rep' })
vim.keymap.set('n', '<leader>sG', require('telescope.builtin').git_files, { desc = '[s]earch [G]it Files' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[s]earch [h]elp' })
vim.keymap.set('n', '<leader>sl', require('telescope.builtin').loclist, { desc = '[s]earch [l]oclist' })
vim.keymap.set('n', '<leader>sm', require('telescope.builtin').man_pages, { desc = '[s]earch [m]an pages' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[s]earch [r]esume' })
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[s]earch [s]elect Telescope' })
vim.keymap.set('n', '<leader>st', "<cmd>TodoTelescope<cr>", { desc = '[s]earch [t]odos' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[s]earch current [w]ord' })


-- SEARCHING THROUGH TODOS
local todo  = require('todo-comments')
vim.keymap.set("n", "]t", function() todo.jump_next() end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function() todo.jump_prev() end, { desc = "Previous todo comment" })
vim.keymap.set("n", "]f", function() todo.jump_next({keywords = { "FIX","FIXME","FIXIT","ERROR", "WARNING" }}) end, { desc = "Next fix comment" })
vim.keymap.set("n", "[f", function() todo.jump_next({keywords = { "FIX","FIXME","FIXIT","ERROR", "WARNING" }}) end, { desc = "Previous fix comment" })
vim.keymap.set("n","<leader>lt","<cmd>TodoQuickFix<cr>",{desc = "[l]ist [t]odos"})
vim.keymap.set("n","<leader>lf","<cmd>TodoQuickFix keywords=FIX,FIXME,FIXIT,ERROR,WARNING<cr>",{desc = "[l]ist [f]ixmes"})

-- g{ and g} to move to new paragraph, not to the spaces between them
vim.keymap.set('n','g}','2}{j',{noremap=true, desc='into next paragraph'})
vim.keymap.set('n','g{','2{j',{noremap=true, desc='into previous paragraph'})

-- DIAGNOSTICS / LSP

-- :h diagnostic-toggle-virtual-lines-example
vim.keymap.set('n', 'gK', function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })

-- ZEN MODE

vim.keymap.set('n','<leader>z', function() require("zen-mode").toggle() end, { desc = 'Toggle zen-mode' })
