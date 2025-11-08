-- show indentation guides
--
-- depends on treesitter

addPlugs({"https://github.com/lukas-reineke/indent-blankline.nvim"})

require('ibl').setup({
    indent = { char = '▏'},
})
