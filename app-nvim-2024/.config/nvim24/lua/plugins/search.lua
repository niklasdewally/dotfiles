-- Use telescope for search
-- More search stuff for lsp stuff is defined in lsp.lua 


-- quicklist menu setup
vim.keymap.set("n","<leader>lo","<cmd>copen<cr>",{desc = "[l]ist [o]pen"})
vim.keymap.set("n","<leader>lc","<cmd>ccl<cr>",{desc = "[l]ist [c]lose"})
vim.keymap.set("n","<leader>ld",function() vim.diagnostic.setqflist() end,{desc = "[l]ist [d]iagnostics"})

-- also, use [q and ]q from vim-unimpaired, and ctrl-q to send telescope to quickfix

return {
  {'nvim-telescope/telescope.nvim',
    -- FIXME: update to a release branch for nvim v0.11 once one is made
    commit= 'a4ed82509cecc56df1c7138920a1aeaf246c0ac5',
    dependencies = {
      {'nvim-lua/plenary.nvim'},
-- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    config  = function(_,_) 
      require('telescope').setup ({
        -- disable default mappings
        defaults = { mappings = { i = { ['<C-u>'] = false, ['<C-d>'] = false , ['C-h'] = "which_key", ['C-q'] = "smart_send_to_qflist"}}},
      })
-- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')

      -- From kickstart
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

    end
  },
  -- highlight and list todos 
  {"folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function(_,_)
      local todo  = require('todo-comments')
      local opts = {
        -- from https://github.com/folke/todo-comments.nvim/issues/195
        search = {
          pattern = [[\b(KEYWORDS)( *\([[:alnum:]-]+\) *)?:]],
        },
        highlight = {
          pattern = [[<(KEYWORDS)( *\([[:alnum:]-]+\) *)?:]],
        }
      }
      todo.setup(opts)

      vim.keymap.set("n", "]t", function()
        todo.jump_next()
      end, { desc = "Next todo comment" })

      vim.keymap.set("n", "[t", function()
        todo.jump_prev()
      end, { desc = "Previous todo comment" })

      vim.keymap.set("n", "]f", function()
        todo.jump_next({keywords = { "FIX","FIXME","FIXIT","ERROR", "WARNING" }})
      end, { desc = "Next fix comment" })

      vim.keymap.set("n", "[f", function()
        todo.jump_next({keywords = { "FIX","FIXME","FIXIT","ERROR", "WARNING" }})
      end, { desc = "Previous fix comment" })

      vim.keymap.set("n","<leader>lt","<cmd>TodoQuickFix<cr>",{desc = "[l]ist [t]odos"})
      vim.keymap.set("n","<leader>lf","<cmd>TodoQuickFix keywords=FIX,FIXME,FIXIT,ERROR,WARNING<cr>",{desc = "[l]ist [f]ixmes"})
    end
  },


  -- nicer quickfix box
  {'yorickpeterse/nvim-pqf'}

}
