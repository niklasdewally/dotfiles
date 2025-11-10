-- lsp server configuration

-- Lsp servers to enable. See :h lspconfig-all for a full list of supported servers.

-- The following language servers should not be enabled here, as they are
-- configured by a plugin:
--
--   * Essence / Conjure 
--   * Rust
--   * Haskell
--
--   See: 40_language_plugins.
--
-- Override settings for specific servers can can be found in after/lsp/<lang>.lua.

loadPlugins({
  -- default lsp configurations
    "https://github.com/neovim/nvim-lspconfig",
  -- show lsp status in bottom right
    "https://github.com/j-hui/fidget.nvim"
})

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
  'pylsp', -- python lsp
  'vimls', -- neovim
})

-- runs when lsp activates
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    -- add grf to format buffer if supported
    if client:supports_method('textDocument/formatting') then
      vim.keymap.set('n', 'grf', vim.lsp.buf.format)
    end
  end})
