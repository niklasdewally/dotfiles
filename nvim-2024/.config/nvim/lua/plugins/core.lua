-- vim: cc=80
-- Core editor plugins to be always loaded.
--
-- Places to look next:
--
--  * treesitter.lua for syntax highlighting, indentation, and custom text
--  objects.
--  * lsp.lua for completion, lsp client stuff, snippets, mason, ...
--  * find.lua for finding stuff in the code, telescope, ...
--  * keybindings.lua for keybindings / which-key. 
--    This is where I give the keybind groups given when space is pressed names.

local opt = vim.opt
local g = vim.g
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

return {
  -- colour scheme
  { 'sainnhe/gruvbox-material', 
    dependencies = {'nvim-treesitter/nvim-treesitter'},
    config = function(_,_)
      g.gruvbox_material_background = "soft"
      g.gruvbox_material_better_performance = 0
      g.gruvbox_material_diagnostic_virtual_text = "colored"
      -- goodbye gruvbox-material
      -- vim.cmd [[colorscheme gruvbox-material]]
      --opt.termguicolors = true
      --opt.background = "dark"
    end
  },
  {'rebelot/kanagawa.nvim', -- more colours
    dependencies = {'nvim-treesitter/nvim-treesitter'},
    config = function(_,_)
      vim.cmd("colorscheme kanagawa-dragon")
    end
  },
  'sainnhe/everforest', -- even more colours
  'airblade/vim-gitgutter', -- show git diff info in status-bar
  'tpope/vim-surround',     -- ys<motion><b class=bolder> or VS<b class=bolder>
  'tpope/vim-fugitive',     -- git wrapper (run :Git )
  'tpope/vim-unimpaired', 
  'tpope/vim-rhubarb',      -- github for fugitive
  'tpope/vim-commentary',   -- gcc to uncomment line , Vgc , ...
  'isobit/vim-caddyfile',
  {'lukas-reineke/indent-blankline.nvim', -- indentation guides
    dependencies = {'nvim-treesitter/nvim-treesitter','sainnhe/gruvbox-material'},
    main="ibl",
    opts={
      indent= {
        char="|",
        tab_char="|",
      },
      scope = {
        char="▎",
        show_start=true,
        show_end=true,
      }
    },
    config=true,
  } -- show indentation guides
}
