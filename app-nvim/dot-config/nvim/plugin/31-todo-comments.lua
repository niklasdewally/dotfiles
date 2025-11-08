-- this uses a .setup() function and must be loaded after telescope :(
vim.pack.add({{src = "https://github.com/folke/todo-comments.nvim"}})
require('telescope')
require("todo-comments").setup({})
-- TODO:
