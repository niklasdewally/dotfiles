return { 
  { -- zenmode
    "folke/zen-mode.nvim",
    deps = {
      "folke/twilight.nvim"
    },
    opts = {
      window  = {
        width = 0.85,
        options = {
          signcolumn = "no", -- disable signcolumn
          number = false , -- disable number column
          relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          list = false, -- disable whitespace characters
        },
      },

      plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
          enabled = true,
          ruler = false, -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
          -- you may turn on/off statusline in zen mode by setting 'laststatus' 
          -- statusline will be shown only if 'laststatus' == 3
          laststatus = 0, -- turn off the statusline in zen mode
        },

        tmux = {enabled = true}, -- disable tmux statusline when in zenmode
        todo = {enabled = true}, -- disable todo comment highlighting in zenmode
        twilight = {enabled = false} -- enable twilight manually
      }
    }
  },

  { -- dim unused parts of the code using treesitter when in zenmode
    "folke/twilight.nvim", 
    opts = {},
  }
}
