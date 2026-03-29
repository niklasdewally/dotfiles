-- this uses a .setup() function and must be loaded after telescope :(
loadPlugins({{src = "https://github.com/folke/todo-comments.nvim"}})
require('telescope')
require("todo-comments").setup({})
-- TODO:
