-- mini.nvim and other small things
-- these replace many things I used to use timpope plugins for - these are LSP
-- and TS aware!
--
-- dependencies: treesitter, lsp (as these plugins are lsp and treesitter aware)

vim.pack.add({'https://github.com/nvim-mini/mini.nvim'})

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

