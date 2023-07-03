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
        triggers = { "<leader>" }
      }
    end
  }

  -- Aesthetics
  use "sainnhe/gruvbox-material"
  use "airblade/vim-gitgutter" -- show git diff info in status-bar
  use "lukas-reineke/indent-blankline.nvim" -- show indentation guides

  -- Search
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- REPL Integration
  use 'jpalardy/vim-slime' -- Send code to a tmux tab (running an interpreter) by C-c C-c

  -- Markdown Writing
  use 'vim-pandoc/vim-pandoc'
  use 'vim-pandoc/vim-pandoc-syntax'
  use 'dhruvasagar/vim-table-mode'

  use { 'quarto-dev/quarto-nvim',
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

  use 'benknoble/vim-racket' -- basic language plugin
  use 'kien/rainbow_parentheses.vim'

  use 'kovisoft/slimv' -- emacs-paredit like functionality (auto close brackets)

  -- HTML / CSS
  use 'gregsexton/matchtag' -- match HTML tags

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      { -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' }, -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' }, -- Required
    }
  }
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

  -- Tim pope utilities
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive' -- git wrapper (run :Git )

  -- Treesitter

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
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
vim.o.timeoutlen = 500

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

vim.opt.termguicolors = true

vim.opt.background = "dark"
vim.g.gruvbox_material_background = "soft"
vim.g.gruvbox_material_better_performance = 1

vim.g.gruvbox_material_diagnostic_virtual_text = "colored"

vim.cmd [[colorscheme gruvbox-material]]
-- }}}
-- TREESITTER {{{

require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {
    'bash',
    'bibtex',
    'c',
    'cpp',
    'css',
    'diff',
    'dockerfile',
    'dot',
    'gitcommit',
    'haskell',
    'json',
    'lua',
    'make',
    'markdown',
    'markdown_inline',
    'nix',
    'python',
    'r',
    'rust',
    'toml',
    'typescript',
    'vim',
    'vimdoc'
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

  highlight = {
    enable = true,
  },
}

-- }}}
-- LSP {{{

local foo = "bar"
local lsp = require('lsp-zero')

lsp.preset("recommended")

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

lsp.ensure_installed({
  'asm_lsp',
  'clangd',
  'jdtls',
  'jedi_language_server',
  'lua_ls',
  'pyre',
  'r_language_server',
  'ruff_lsp',
  'tsserver',
})

require("lspconfig").hls.setup { -- Haskell
  settings = {
    haskell = {
      cabalFormattingProvider = "cabalfmt",
      formattingProvider = "ormolu",
      plugin = { rename = { config = { crossModule = true } }
      }
    }
  }
}

lsp.setup()



local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black, -- python formatting
    null_ls.builtins.formatting.shfmt -- shell formatting
  },
})


local cmp = require('cmp')
cmp.setup({
  completion = {
    autocomplete = false
  },
  mapping = {
    ["<C-Space>"] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({select = false}),
  }
})

-- Show virtual text for warnings and errors only
vim.diagnostic.config({
  virtual_text = {
    severity= {min = vim.diagnostic.severity.WARN },
    source="if_many",
  },
  underline  = true,
  signs = true
})

vim.keymap.set('n','g?',function() vim.diagnostic.open_float({}) end, { silent = true})

-- Keep gutter open to stop text wiggling around
vim.opt.signcolumn = "yes"

-- }}}
-- SLIME REPL {{{
vim.g.slime_bracketed_paste = 1
vim.g.slime_target = "tmux"

-- guess tmux pane
vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}" }

-- }}}https://indicators.ohchr.org/
-- KEYBINDINGS {{{

vim.g.mapleader = " "
vim.api.nvim_create_user_command("CodeAction",function() vim.lsp.buf.code_action({apply=true}) end,{})


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
    f = {
      name = "+find",
      e = { "<cmd>Explore<cr>", ":open filetree in current buffer" },
      E = { "<cmd>Sexplore<cr>", "open file-tree in new split buffer" },
      f = { telescope.find_files, "find file" },
      s = { telescope.live_grep, "find string" }
    },
    l = {
      name = "+lsp",
      a = { function() lbuf.code_action({apply=true}) end, "code action" },
      d = { lbuf.definition, "goto definition (equivalent to C-[)" },
      f = { lbuf.format, "format buffer. (equivalent to Ggqg)" },
      i = { lbuf.implementation, "list implementations" },
      r = { lbuf.rename, "rename" },
      R = { lbuf.references, "list references" },
      s = { lbuf.signature_help, "view signature" },
      S = { lbuf.workspace_symbol, "view symbols in current workspace" },
      t = { lbuf.type_definition, "goto type definition" },
    },
    h = { lbuf.hover, "open lsp hover window", noremap = true },
    q = {
      name = "+quarto",
      p = { quarto.quartoPreivew, "preview" }
    }
  },
})


-- }}}
