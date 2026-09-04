-- Using builtin completion, as it now has fuzzy matching (as of neovim 0.11).
--
-- I do not use auto-completion, so this should be sufficient.

vim.opt.completeopt = { 'fuzzy', 'menu', 'popup', 'nosort',  'menuone'}
vim.opt.complete = { 'o', 'F', 'k', '.', 'f', 'b'}
