-- :PackClean command to remove all plugins

vim.api.nvim_create_user_command("PackClean", function(opts)
  -- from :h vim.pack
  vim.iter(vim.pack.get())
   :filter(function(x) return not x.active end)
   :map(function(x) return x.spec.name end)
   :totable()


  vim.cmd.restart{ bang=opts.bang }

end, {
  nargs= 0,
  desc = "Uninstall vim.pack plugins that are not in neovim config, and restart neovim.",
  bang= true
  })
