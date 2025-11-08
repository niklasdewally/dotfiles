--- Completion
-- completion using blink.cmp

return {
  {'Saghen/blink.cmp',
  version="1.*",
  dependencies = { 
    'L3MON4D3/LuaSnip', version = 'v2.*',
    'numToStr/Comment.nvim', -- I use this in my snippets
  },
  opts = {
    snippets = {preset = 'luasnip'},
    keymap = {preset = 'default'},
    completion = { 
      -- don't automatically show the completion menu
      menu = { auto_show = false},

      -- only show documentation popup when manually triggered.
      documentation = { auto_show = false },
    },
  },
  opts_extend = {"sources.default"},
  config = function(_, opts)


    local luasnip = require('luasnip')
    require('luasnip').setup({
      enable_autosnippets = true,
    })

    -- first setup luasnip
    require('luasnip.loaders.from_vscode').lazy_load()
    require("luasnip.loaders.from_snipmate").lazy_load()
    require("luasnip.loaders.from_lua").lazy_load()

    -- username for use in todo snippet
    vim.g.snip_username = "niklasdewally"

    -- Make honza/vim-snippets work
    luasnip.filetype_extend("all", { "_" })

    luasnip.config.set_config({
      history = true,
      region_check_events = "CursorMoved,CursorHold,InsertEnter",

      -- fix https://github.com/L3MON4D3/LuaSnip/issues/116
      delete_check_events = 'TextChanged,InsertLeave',
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,
    })

    -- custom snippets
    require("luasnip.loaders.from_snipmate").lazy_load({paths="~/.snippets/snippets"})
    require("luasnip.loaders.from_lua").lazy_load({paths="~/.snippets/luasnippets"})

    vim.keymap.set('n', "<leader>Se", function() require("luasnip.loaders").edit_snippet_files({
      extend = function(ft, paths)
        if #paths == 0 then
          return {
            { ".snippets/" .. ft .. ".snippets",
            string.format("~/.snippets/snippets/%s.snippets",ft)}
          }
        end

        return {}
      end
    }) end,
    { desc = "edit snippet files" })

    require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. '/snippets/lua' } })

    require('blink.cmp').setup(opts)
  end
}
}
