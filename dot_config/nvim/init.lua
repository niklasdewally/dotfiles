-- vim:foldmethod=marker
-- AUTOINSTALL PACKER {{{
-- Adapted from https://github.com/wbthomason/packer.nvim
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

ensure_packer()
-- }}}
-- PLUGINS {{{
require('packer').startup(function(use)
	-- LARGELY COPIED FROM .VIMRC

	use 'wbthomason/packer.nvim'

	-- Aesthetics
	use "ellisonleao/gruvbox.nvim"
	use "airblade/vim-gitgutter" -- show git diff info in airline

	-- Navigation
	use "preservim/nerdtree" -- file browsing

	-- TODO: telescope or fzf?

	-- REPL Integration
	use 'jpalardy/vim-slime' -- REPL Integration

	-- Markdown Writing
	use 'vim-pandoc/vim-pandoc'
	use 'vim-pandoc/vim-pandoc-syntax'
	use 'dhruvasagar/vim-table-mode'

	--  Racket / Scheme
	-- See: https://docs.racket-lang.org/guide/Vim.html
	use 'benknoble/vim-racket' -- basic language plugin
	use 'kien/rainbow_parentheses.vim'

	-- use this one for emacs-paredit like functionality (auto close brackets, plus
	-- some other vim keybindings!) - it also supports REPL stuff, but not for
	-- racket!
	use 'kovisoft/slimv'

	-- HTML / CSS
	use 'gregsexton/matchtag' -- match HTML tags

	-- Haskell
	-- use 'neovimhaskell/haskell-vim'
	use 'monkoose/fzf-hoogle.vim'

	-- LSP
	use "williamboman/mason.nvim" -- local package manager for lsp stuff
	use "williamboman/mason-lspconfig.nvim"
	use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
	use 'ii14/lsp-command' -- provide command interface to lsp functions

	-- Automatically set up your configuration after cloning packer.nvim
	if packer_bootstrap then
		require('packer').sync()
	end

end)
-- }}}
-- EDITOR {{{

vim.opt.rnu = true
vim.opt.nu = true

vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

-- }}}
-- EDITOR: COLOUR SCHEME {{{

vim.opt.background = "dark"
vim.cmd([[ colorscheme gruvbox ]])

-- }}}
-- DIAGNOSTIC INFO {{{

-- Hide diagnostics by default, apart from in gutter
vim.diagnostic.config({
	virtual_text = false,
	underline = false
})
-- Keep gutter open to stop text wiggling around
vim.opt.signcolumn = "yes"

-- Use commands :ShowErrors and :HideErrors to view/hide diagnostic info
vim.api.nvim_create_user_command("HideErrors",
	'lua vim.diagnostic.show(nil,nil,nil,{virtual_text=false,underline=false})', {})

vim.api.nvim_create_user_command("ShowErrors",
	'lua vim.diagnostic.show(nil,nil,nil,{virtual_text=true,underline=true})', {})

-- }}}
-- LSP {{{

require("mason").setup()
require("mason-lspconfig").setup()


-- list of lsp servers to be installed

require("lspconfig").ansiblels.setup {}     -- Ansible
require("lspconfig").asm_lsp.setup {}       -- Assembly
require("lspconfig").clangd.setup {}        -- C / C++
require("lspconfig").cssls.setup {}         -- CSS
require("lspconfig").dotls.setup{} 	    -- DOT (Graphviz)
require("lspconfig").hls.setup {}           -- Haskell
require("lspconfig").idris2_lsp.setup {}    -- Idris
require("lspconfig").jdtls.setup {}         -- Java
require("lspconfig").jsonls.setup{}         -- JSON
require("lspconfig").sumneko_lua.setup {}   -- Lua
require("lspconfig").pyright.setup{} 	    -- Python (static analysis only)
require("lspconfig").tsserver.setup {}      -- Typescript; Javascript
