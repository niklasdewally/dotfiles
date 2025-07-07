-- lsp server configuration

-- Lsp servers to enable. See :h lspconfig-all for a full list of supported servers.

-- The following languages should not be enabled manually, as they are configured by a plugin:
--   * Essence / Conjure 
--   * Rust
--   * Haskell

-- TODO: install script for all these!
-- (maybe use nix?)
vim.lsp.enable({
  'asm_lsp', -- asm
  'awk_ls',  -- awk
  'bashls',  -- bash
  'clangd', -- c
  'cmake', -- cmake
  'elp', -- erlang
  'gh_actions_ls', -- github actions
  'harper_ls', -- grammar
  'idris2_lsp', -- idris
  'ltex', -- latex
  'lua_ls', -- lua
  'marksman', -- markdown
  'r_language_server', -- r
  'ruff', -- python linter
  'vimls', -- neovim
})


