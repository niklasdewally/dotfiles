-- this uses a .setup() function and must be loaded after telescope :(
addPlugs({{src = "https://github.com/folke/todo-comments.nvim"}})
require('telescope')
require("todo-comments").setup({})
-- TODO:
