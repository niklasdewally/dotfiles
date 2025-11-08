--- Completion using blink.cmp, and extra completion sources

vim.pack.add({
  { src = 'https://github.com/saghen/blink.cmp',         version = vim.version.range('~1') },
  { src = 'https://github.com/Kaiser-Yang/blink-cmp-git' }
})

local blink = require('blink.cmp')

-- to
blink.setup({
  snippets = { preset = 'luasnip' },
  keymap = { preset = 'default' },
  completion = {
    -- don't automatically show the completion menu
    menu = { auto_show = false },

    -- only show documentation popup when manually triggered.
    documentation = { auto_show = false },
  },

  sources = {
    default = { 'lsp', 'buffer', 'snippets', 'path' },
  -- TODO: add more sources
    per_filetype = {
      -- ..
    },

    providers = {

    }
  }
})
