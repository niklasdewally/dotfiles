-- calls vim.pack.add with load = true, instead of the default load=false.
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
function addPlugs (spec)
  vim.pack.add(spec,{load=true,confirm=false})
end
