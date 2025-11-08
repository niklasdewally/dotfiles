-- show indentation guides
--
-- depends on treesitter

loadPlugins({"https://github.com/lukas-reineke/indent-blankline.nvim"})

require('ibl').setup({
    indent = { char = '▏'},
})
