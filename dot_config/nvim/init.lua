-- vim:foldmethod=marker
local opt = vim.opt

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

	use 'wbthomason/packer.nvim'



  -- Which key (keybindings)
  use {
  "folke/which-key.nvim",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
    require("which-key").setup {
      triggers = {"<leader>"}
    }
  end
  }

	-- Aesthetics
  use "sainnhe/gruvbox-material"
	use "airblade/vim-gitgutter"              -- show git diff info in status-bar
  use "lukas-reineke/indent-blankline.nvim" -- show indentation guides

  -- Search
   use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

	-- REPL Integration
	use 'jpalardy/vim-slime'                  -- Send code to a tmux tab (running an interpreter) by C-c C-c

	-- Markdown Writing
	use 'vim-pandoc/vim-pandoc'
	use 'vim-pandoc/vim-pandoc-syntax'
	use 'dhruvasagar/vim-table-mode'

  use {'quarto-dev/quarto-nvim',
    dependencies = { 'vim-pandoc/vim-pandoc-syntax' },
    config = function()
	 -- conceal can be tricky because both
	 -- the treesitter highlighting and the
	 -- regex vim syntax files can define conceals
	 --
	 -- -- see `:h conceallevel`
   vim.opt.conceallevel = 1
    --
    -- -- disable conceal in markdown/quarto
   vim.g['pandoc#syntax#conceal#use'] = false
    --
    -- -- embeds are already handled by treesitter injectons
   vim.g['pandoc#syntax#codeblocks#embeds#use'] = false
   vim.g['pandoc#syntax#conceal#blacklist'] = { 'codeblock_delim', 'codeblock_start' }
    --
    -- -- but allow some types of conceal in math regions:
    -- see `:h g:tex_conceal`
   vim.g['tex_conceal'] = 'gm'
   end
  }

use 'hrsh7th/nvim-cmp' -- required by quarto
use 'jmbuhr/otter.nvim' -- required by quarto

	--  Racket / Scheme
  
	-- See: https://docs.racket-lang.org/guide/Vim.html
 
	use 'benknoble/vim-racket'             -- basic language plugin
	use 'kien/rainbow_parentheses.vim'

	use 'kovisoft/slimv'                   -- emacs-paredit like functionality (auto close brackets)

	-- HTML / CSS
	use 'gregsexton/matchtag'              -- match HTML tags

	-- LSP
	use "williamboman/mason.nvim" -- local package manager for lsp stuff
  use "jay-babu/mason-null-ls.nvim" -- auto install null-ls formatters
	use "williamboman/mason-lspconfig.nvim" -- auto install lsp clients

  use {                     
  "folke/trouble.nvim",
  requires = "nvim-tree/nvim-web-devicons",
  config = function()
    require("trouble").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end
}

	use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use 'jose-elias-alvarez/null-ls.nvim'
	use 'ii14/lsp-command' -- provide command interface to lsp functions

  -- Tim pope utilities
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive' -- git wrapper (run :Git )

  -- Treesitter

use {'nvim-treesitter/nvim-treesitter',
  tag = nil,
  branch = 'master',
  run = ':TSUpdate',
  config = function()
    require 'nvim-treesitter.configs'.setup {
      ensure_installed = {
        'r', 'python', 'markdown', 'markdown_inline',
        'julia', 'bash', 'yaml', 'lua', 'vim',
        'query', 'vimdoc', 'latex', 'html', 'css'
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'markdown' },
      },
    }
  end
    }


	-- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
		require('packer').sync()
	end

end)
-- }}}
-- EDITOR {{{

opt.rnu = true
opt.nu = true

vim.o.timeout = true
vim.o.timeoutlen=500

opt.autoindent = true
opt.expandtab = true
opt.smartindent = true

opt.tabstop = 2
opt.shiftwidth = 2

-- show indent guides
require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}


-- }}}
-- EDITOR: COLOUR SCHEME {{{
  --
vim.opt.background = "dark"
vim.g.gruvbox_material_background = "soft"
vim.g.gruvbox_material_better_performance = 1

vim.cmd[[colorscheme gruvbox-material]]
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


vim.api.nvim_create_user_command("CodeAction",function() vim.lsp.buf.code_action({apply=true}) end,{})
vim.api.nvim_create_user_command("Ca",function() vim.lsp.buf.code_action({apply=true}) end,{})

-- from https://github.com/neovim/nvim-lspconfig
local opts = { noremap=true, silent=true }


-- list of lsp servers available to use

require("lspconfig").ansiblels.setup {}     -- Ansible
require("lspconfig").asm_lsp.setup {}       -- Assembly
require("lspconfig").bashls.setup {}        -- Bash
require("lspconfig").clangd.setup {}        -- C / C++
require("lspconfig").cssls.setup {}         -- CSS
require("lspconfig").dotls.setup{} 	        -- DOT (Graphviz)
require('lspconfig').r_language_server.setup{}
require("lspconfig").hls.setup {            -- Haskell
  settings = {
    haskell = {
      cabalFormattingProvider = "cabalfmt",
      formattingProvider = "ormolu",
      plugin = {rename = {config = {crossModule = true}}
  }}
  }}

require("lspconfig").idris2_lsp.setup {}           -- Idris
require("lspconfig").jdtls.setup {}                -- Java
require("lspconfig").jsonls.setup{}                -- JSON
require("lspconfig").lua_ls.setup {}               -- Lua
require("lspconfig").tsserver.setup{}              -- Typescript; Javascript
require("lspconfig").rust_analyzer.setup{}         -- Rust
require('lspconfig').ruff_lsp.setup{}                    -- Python
require('lspconfig').jedi_language_server.setup{}                    -- Python


local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black, -- python formatting
        null_ls.builtins.formatting.shfmt  -- shell formatting
    },
})

require("mason-null-ls").setup({
    automatic_setup = true
})

-- Install python dependencies
-- Use black as pyrt

-- }}}
-- SLIME REPL {{{
vim.g.slime_bracketed_paste = 1
vim.g.slime_target = "tmux"

-- guess tmux pane
vim.g.slime_default_config = {socket_name = "default", target_pane = "{last}"}

-- }}}https://indicators.ohchr.org/
-- KEYBINDINGS {{{

vim.g.mapleader = " "

-- which key provides a nice menu to help remember hotkeys!
local wk = require("which-key")

-- plugin aliases
local telescope = require('telescope.builtin')
local lbuf = vim.lsp.buf

vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<Space>hp', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<Space>hs', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<Space>hu', '<Nop>', { noremap = true, silent = true })


local quarto = require('quarto')

wk.register({
  ["<leader>"] = {
    f= {
      name="+find",
      e = {"<cmd>Explore<cr>",":open filetree in current buffer"},
      E = {"<cmd>Sexplore<cr>","open file-tree in new split buffer"},
      f = {telescope.find_files,"find file"},
      s = {telescope.live_grep ,"find string"}},
    l = {
      name="+lsp",
      a = {"<cmd>CodeAction<cr>","code action"},
      e = {"<cmd>ShowErrors<cr>","show inline errors"},
      E = {"<cmd>HideErrors<cr>","hide inline errors"},
      d = {lbuf.definition,"goto definition (equivalent to C-[)"},
      f = {lbuf.format,"format buffer. (equivalent to Ggqg)"},
      i = {lbuf.implementation,"list implementations"},
      r = {lbuf.rename,"rename"},
      R = {lbuf.references,"list references"},
      s = {lbuf.signature_help,"view signature"},
      S = {lbuf.workspace_symbol,"view symbols in current workspace"},
      t = {lbuf.type_definition,"goto type definition"},
    },
    h = {lbuf.hover,"open lsp hover window",noremap=true},
    q= {
      name="+quarto",
      p={quarto.quartoPreivew,"preview"}
    }
  },
})

    
-- }}}
-- QUARTO {{{
require('quarto').setup({
  lspFeatures = {
    enabled = true,
    languages = { 'r', 'python', 'julia', 'bash' },
    chunks = 'curly', -- 'curly' or 'all'
    }
})
-- }}}
