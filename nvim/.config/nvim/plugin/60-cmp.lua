--- Completion using blink.cmp, and extra completion sources

loadPlugins({
  { src = 'https://github.com/saghen/blink.cmp',         version = vim.version.range('~1') },
  { src = 'https://github.com/Kaiser-Yang/blink-cmp-git' }
})

local blink = require('blink.cmp')

-- to
blink.setup({
  keymap = { preset = 'default' },
  completion = {
    menu = {
      draw = {
        columns = { { "label", "label_description", gap = 1 }, { "kind_icon", gap = 1}, { "kind" } }
      },
      auto_show = false
    },
    documentation = { auto_show = true , auto_show_delay_ms = 200},
  },

  sources = {
    default = { 'lsp', 'buffer', 'path' },
  -- TODO: add more sources
    per_filetype = {
      -- ..
    },

    providers = {

    }
  }
})
