return {
  "lukas-reineke/indent-blankline.nvim",
  dependencies = {'nvim-treesitter/nvim-treesitter'},
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config

  config = function() 

    local hooks = require "ibl.hooks"

    local opts = {
      indent = { char = '▏'},
    }


    require('ibl').setup(opts)


  end

}


