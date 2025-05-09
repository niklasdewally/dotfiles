-- Builtin vim options

vim.opt.rnu = true -- relative line number
vim.opt.nu = true -- absolute line number

vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Keep gutter open to stop text wiggling around
vim.opt.signcolumn = "yes"

-- always use the clipboard for all operations
-- vim.o.clipboard = unnamedplus

-- vim.o.colorcolumn = "80"

-- highlight the text line of the cursor
vim.o.cursorline = true

-- vim.cmd('au WinLeave * set nocursorline nocursorcolumn')
-- vim.cmd('au WinEnter * set cursorline cursorcolumn')

vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.o.smartcase = true
vim.o.smartindent = true

vim.o.undofile = true
vim.o.undolevels = 10000

vim.o.wrap = false

vim.g.editorconfig = true

-- disable providers (see :h provider)
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

