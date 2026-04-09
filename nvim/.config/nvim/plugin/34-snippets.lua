-- Snippets using luasnip

-- run build-script for LuaSnip on install
local hooks = function(ev)
  -- Use available |event-data|
  local name, kind = ev.data.spec.name, ev.data.kind

  -- Run build script after plugin's code has changed
  if name == 'LuaSnip' and (kind == 'install' or kind == 'update') then
    vim.system({ 'make', 'install_jsregexp' }, { cwd = ev.data.path })
  end
end

-- If hooks need to run on install, run this before `addPlugs()`
vim.api.nvim_create_autocmd('PackChanged', { callback = hooks })

loadPlugins({"https://github.com/L3MON4D3/LuaSnip"})


