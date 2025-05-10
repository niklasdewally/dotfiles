-- This file defines lsp related plugins only: for lsp configuration, see
-- config/lsp.lua.

return {

  { -- show lsp status messages in bottom right
    "j-hui/fidget.nvim",
    opts = {},
  },

  { -- default lsp configurations.
    'neovim/nvim-lspconfig'
  }

}
