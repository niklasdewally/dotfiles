-- Various colour schemes I like
-- Default colour scheme is set in config.colourscheme

-- use :colourscheme or telescope <SPC>ss colour to search through these.

return {
  -- {'sainnhe/everforest',
  --   lazy = false,
  --   priority = 1000,
  --   -- config = function()
  --   --   -- Optionally configure and load the colorscheme
  --   --   -- directly inside the plugin declaration.
  --   --   vim.g.everforest_enable_italic = true
  --   --   vim.cmd.colorscheme('everforest')
  --   -- end
  -- },
  --
  -- {'everviolet/nvim', name = 'evergarden',
  --   lazy=false,
  --   priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
  --   opts = {
  --     theme = {
  --       variant = 'winter', -- 'winter'|'fall'|'spring'|'summer'
  --       accent = 'green',
  --     },
  --     editor = {
  --       transparent_background = false,
  --       sign = { color = 'none' },
  --       float = {
  --         color = 'mantle',
  --         invert_border = false,
  --       },
  --       completion = {
  --         color = 'surface0',
  --       },
  --     },
  --   }
  -- },
  -- {"forest-nvim/sequoia.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   -- config = function()
  --   --   vim.cmd("colorscheme sequoia") -- or 'sequoia-night' / 'sequoia-rise'
  --   -- end
  -- },

  {"thesimonho/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    opts = {},},

  -- {"rebelot/kanagawa.nvim",
  --   lazy=false,
  --   priority=1000,
  -- },

  {"vague2k/vague.nvim",
    lazy=false,
    priority=1000,
  },

}
