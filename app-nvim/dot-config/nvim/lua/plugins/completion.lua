--- Completion
-- completion using blink.cmp


return {
  {'Saghen/blink.cmp',
  version="1.*",
  opts = {
    keymap = {preset = 'default'},

    completion = { 

      -- don't automatically show the completion menu
      menu = { auto_show = false},

      -- only show documentation popup when manually triggered.
      documentation = { auto_show = false },
    },

  },
  opts_extend = {"sources.default"}
}
}
