-- show indentation guides
--
-- depends on treesitter

vim.pack.add({"https://github.com/lukas-reineke/indent-blankline.nvim"})

require('ibl').setup({
    indent = { char = '▏'},
})
