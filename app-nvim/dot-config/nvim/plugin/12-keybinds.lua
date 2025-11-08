-- list of global keybinds

-- use whichkey to show keybinds
loadPlugins({
  { src = 'https://github.com/folke/which-key.nvim',       version = vim.version.range('^3.0') },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' }
})

require("which-key").setup({ icons = { mappings = false } })

vim.cmd([[:hi! link WhichKey Structure]])

-- setup <Leader> and <LocalLeader>
-- vim.keymap.set({'n'},"<Space>","<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = '\\'

-- Group Names / which-key
require("which-key").add({
  -- leader groups and aliases
  { "<leader>s",        group = "search" },
  { "<leader>l",        group = "list" },
  { "<leader><leader>", group = "local-leader",        proxy = "<LocalLeader>" },
  -- { "<leader>l", proxy = "gr" , group = "lsp"},

  -- add descriptions for builtin lsp bindings
  { "gr",               group = "lsp" },
  { "gra",              desc = "Code actions" },
  { "grf",              desc = "Format buffer" },
  { "gri",              desc = "Go to implementation" },
  { "grn",              desc = "Rename symbol" },
  { "grr",              desc = "Go to references" },
  { "grt",              desc = "Go to type definition" }
})

-- DIAGNOSTICS: toggle virtual text with gK
vim.keymap.set('n', 'gK', function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })

-- TELESCOPE: search commands <Leader>s

-- Creates a normal mode mapping <leader>s + suffix
local function map_s(suffix, desc, func)
  vim.keymap.set('n', '<leader>s' .. suffix, func, { desc = 'Search ' .. desc })
end


-- TODO: port from previous config
-- vim.keymap.set('n','<leader>sc', require('niklasdewally.telescope.pickers').git_ref, {desc = '[s]earch git [c]itation (copies citation to clipboard and "0)'})

map_s('?', 'recently opened files', function() require('telescope.builtin').oldfiles() end)
map_s(' ', 'existing buffers', function() require('telescope.builtin').buffers() end)
map_s('d', 'diagnostics', function() require('telescope.builtin').buffers() end)
map_s('e', 'errors', function() require('telescope.builtin').diagnostics({ ["severity"] = "error" }) end)
map_s('f', 'fixmes', "<cmd>TodoTelescope keywords=FIX,FIXME,FIXIT,ERROR,WARNING<cr>")
map_s('F', 'files', function() require('telescope.builtin').find_files() end)
map_s('g', 'grep', function() require('telescope.builtin').live_grep() end)
map_s('G', 'git files', function() require('telescope.builtin').git_files() end)
map_s('h', 'help', function() require('telescope.builtin').help_tags() end)
map_s('l', 'loclist', function() require('telescope.builtin').loclist() end)
map_s('m', 'man pages', function() require('telescope.builtin').man_pages() end)
map_s('r', 'resume', function() require('telescope.builtin').resume() end)
map_s('s', 'select telescope', function() require('telescope.builtin').builtin() end)
map_s('t', 'todos', "<cmd>TodoTelescope<cr>")
map_s('w', 'current word', function() require('telescope.builtin').grep_string() end)

-- SEARCHING THROUGH TODOS
vim.keymap.set("n", "]t", function() require('todo-comments').jump_next() end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function() require('todo-comments').jump_prev() end, { desc = "Previous todo comment" })
vim.keymap.set("n", "]f",
  function() require('todo-comments').jump_next({ keywords = { "FIX", "FIXME", "FIXIT", "ERROR", "WARNING" } }) end,
  { desc = "Next fix comment" })
vim.keymap.set("n", "[f",
  function() require('todo-comments').jump_next({ keywords = { "FIX", "FIXME", "FIXIT", "ERROR", "WARNING" } }) end,
  { desc = "Previous fix comment" })
vim.keymap.set("n", "<leader>lt", "<cmd>TodoQuickFix<cr>", { desc = "[l]ist [t]odos" })
vim.keymap.set("n", "<leader>lf", "<cmd>TodoQuickFix keywords=FIX,FIXME,FIXIT,ERROR,WARNING<cr>",
  { desc = "[l]ist [f]ixmes" })
