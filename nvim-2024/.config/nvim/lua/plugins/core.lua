-- vim: cc=80
-- "Core" editor plugins to be always loaded.
--
-- Plugins that require more configuration or that are lazily loaded can be
-- found elsewhere or in their own files.

local opt = vim.opt
local g = vim.g

return {

  -- Setup colour scheme
  { 'sainnhe/gruvbox-material', 
    config = function(_,_)
      opt.termguicolors = true
      opt.background = "dark"
      g.gruvbox_material_background = "soft"
      g.gruvbox_material_better_performance = 1
      g.gruvbox_material_diagnostic_virtual_text = "colored"
      vim.cmd [[colorscheme gruvbox-material]]
    end
  },

  'airblade/vim-gitgutter', -- show git diff info in status-bar
  'tpope/vim-surround',     -- ys<motion><b class=bolder> or VS<b class=bolder>
  'tpope/vim-fugitive',     -- git wrapper (run :Git )
  'tpope/vim-rhubarb',      -- github for fugitive
  'tpope/vim-commentary',   -- gcc to uncomment line , Vgc , ...
  'lukas-reineke/indent-blankline.nvim',-- show indentation guides
}
