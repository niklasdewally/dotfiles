-- mini.nvim and other small things
-- these replace many things I used to use timpope plugins for - these are LSP
-- and TS aware!
--
-- dependencies: treesitter, lsp (as these plugins are lsp and treesitter aware)

loadPlugins({'https://github.com/nvim-mini/mini.nvim'})

-- enable individual mini plugins:
--
require("mini.ai").setup()
require("mini.surround").setup()
require("mini.bracketed").setup()
require("mini.icons").setup()

-- NOW DONE BY TREESITTER
--
-- -- highlight todo comments
-- local hipatterns = require('mini.hipatterns')
-- hipatterns.setup({
--   highlighters = {
--     -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
--     fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
--     hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
--     todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
--     note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },
--
--     -- Highlight hex color strings (`#rrggbb`) using that color
--     hex_color = hipatterns.gen_highlighter.hex_color(),
--   },
-- })


-- Snippets:
-- see also: 34-nvim-scissors.lua
--
-- use ctrl-j to expand snippet based on typed text
-- use ctrl-l and ctrl-h to jump to next and previous completion
-- use ctrl-n and ctrl-p to select choices in tabstops
-- use ctrl-c to terminate

local gen_loader = require('mini.snippets').gen_loader

require('mini.snippets').setup({
  snippets = {
    -- -- Load custom file with global snippets first
    gen_loader.from_file('~/.config/nvim/snippets/global.json'),

    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),

  -- Load vscode project-local snippets with `gen_loader.from_file()`
  -- and relative path (file doesn't have to be present)
  gen_loader.from_file('.vscode/project.code-snippets'),

    -- Custom loader for vscode language-specific project-local snippets
    function(context)
      local rel_path = '.vscode/' .. context.lang .. '.code-snippets'
      if vim.fn.filereadable(rel_path) == 0 then return end
      return MiniSnippets.read_file(rel_path)
    end,
  },
})

-- integrate snippets with autocomplete
require('mini.snippets').start_lsp_server({match= false})

