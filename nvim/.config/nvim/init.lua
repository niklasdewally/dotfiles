-- Register post-install hooks for plugins.
-- These must be placed before the first vim.pack.add call - see
-- https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack.html#hooks 

vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == 'nvim-treesitter' and kind == 'update' then
    if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
    vim.cmd('TSUpdate')
  end
end })

-- calls vim.pack.add with load = true, instead of the default load=false.
--
-- Plugin contents are loaded immediately after installation; therefore, 
-- plugin related vim.g settings should be defined before this call.
--
-- BACKGROUND
--
-- When calling vim.pack.add in init.lua, the plugin directory of added 
-- directories are not loaded to avoid loading them twice, as these will be 
-- loaded in the next stage of initialisation (:h load-plugins), 
-- which reads all plugin/*.{vim,lua} files in the runtime path. However, I am 
-- installing plugins in plugin/ files,  so the plugin/ files of the plugins 
-- I am installing are never getting called.
--
-- (vim does not detect changes to the runtimepath in the load-plugins stage).
--
-- See: https://github.com/neovim/neovim/pull/35270
--  - https://github.com/neovim/neovim/pull/35270#issuecomment-3180056509
--  - :h :packadd (especially the bits about packadd!)
function loadPlugins (spec)
  vim.pack.add(spec,{load=true,confirm=false})
end
