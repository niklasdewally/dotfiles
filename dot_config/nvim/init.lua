-- vim:foldmethod=marker
local opt = vim.opt
local g = vim.g
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
-- PACKER PLUGINS {{{
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'              -- Packer manages itself
  use "folke/which-key.nvim"                -- Keybind menu
  use "sainnhe/gruvbox-material"            -- pretty colours
  use "airblade/vim-gitgutter"              -- show git diff info in status-bar
  use "lukas-reineke/indent-blankline.nvim" -- show indentation guides
  use 'L3MON4D3/LuaSnip'                    -- snippet engine
  use 'honza/vim-snippets'                  -- snipmate snippet pack
  use { 'saadparwaiz1/cmp_luasnip' }        -- add snippets to completion engine
  use { 'numToStr/Comment.nvim' }           -- required for box snippets
  use {
    'nvim-telescope/telescope.nvim',        -- fuzzy find
    tag = '0.1.1',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use 'vim-pandoc/vim-pandoc'
  use 'vim-pandoc/vim-pandoc-syntax'
  use 'dhruvasagar/vim-table-mode' -- nice markdown tables
  use { 'quarto-dev/quarto-nvim',
    requires = { 'vim-pandoc/vim-pandoc-syntax', 'hrsh7th/nvim-cmp', 'jmbuhr/otter.nvim' },
  }

  use 'jpalardy/vim-slime' -- Send code to a tmux tab (running an interpreter) by C-c C-c
  use 'kovisoft/slimv'     -- emacs-paredit like functionality (auto close brackets)
  use 'kien/rainbow_parentheses.vim'

  use 'gregsexton/matchtag' -- match HTML tags

  -- LSP and diagnostic
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      { 'neovim/nvim-lspconfig' },
      {
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' },
    }
  }

  use 'jose-elias-alvarez/null-ls.nvim'

  use { "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons" }

  -- Tim Pope Utilities
  use 'tpope/vim-surround'   -- ys<motion><b class=bolder> or VS<b class=bolder>
  use 'tpope/vim-fugitive'   -- git wrapper (run :Git )
  use 'tpope/vim-commentary' -- gcc to uncomment line , Vgc , ...

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'niklasdewally/conjure.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- }}}
-- EDITOR OPTIONS {{{

opt.rnu = true
opt.nu = true

opt.timeout = true
opt.timeoutlen = 500

opt.autoindent = true
opt.expandtab = true
opt.smartindent = true

opt.tabstop = 2
opt.shiftwidth = 2


-- disable auto comment on new line
vim.cmd("set formatoptions-=cro")
vim.cmd("autocmd BufNewFile,BufRead * setlocal formatoptions-=cro")

-- Indentation guides
require("indent_blankline").setup {
  show_current_context = true,
  show_current_context_start = true,
}

-- }}}
-- EDITOR: COLOURS {{{

opt.termguicolors = true
opt.background = "dark"

g.gruvbox_material_background = "soft"
g.gruvbox_material_better_performance = 1
g.gruvbox_material_diagnostic_virtual_text = "colored"

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
    'vimdoc',
    'go'
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
-- LUASNIP {{{
ls = require("luasnip")
types = require("luasnip.util.types")

-- I use TAB and S-B to navigate snippets - see lsp-zero config
ls.config.set_config({

  history = true,
  region_check_events = "CursorMoved,CursorHold,InsertEnter",
  -- fix https://github.com/L3MON4D3/LuaSnip/issues/116
  delete_check_events = 'TextChanged,InsertLeave',
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
})


-- Make honza/vim-snippets work
ls.filetype_extend("all", { "_" })

-- use snipmate format snippets
-- store custom shipmate snippets in snippets/<filetype>.snippets
-- this is easier than lua snippet syntax.
-- By default, this installs any snippets/ folder found in runtime path
require("luasnip.loaders.from_snipmate").lazy_load()

-- load lua snippets
-- stored in luasnippets folder
require("luasnip.loaders.from_lua").lazy_load()

-- username for use in todo snippet
g.snip_username = "niklasdewally"

-- }}}
-- LSP {{{

local lsp = require('lsp-zero')

lsp.preset("recommended")

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

lsp.ensure_installed({
  'clangd',
  'jdtls',
  'jedi_language_server',
  'lua_ls',
  'pyre',
  'ruff_lsp',
  'tsserver',
  'csharp_ls',
  'gopls',
  'rust_analyzer'
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
    null_ls.builtins.formatting.shfmt  -- shell formatting
  },
})


local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
  completion = {
    autocomplete = false
  },
  mapping = {
    ["<C-Space>"] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),

  }
})

-- Show virtual text for warnings and errors only
vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
    source = "if_many",
  },
  underline    = true,
  signs        = true
})

vim.keymap.set('n', 'g?', function() vim.diagnostic.open_float({}) end, { silent = true })

-- Keep gutter open to stop text wiggling around
vim.opt.signcolumn = "yes"

--- }}}
-- RUN ON SAVE {{{
vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
vim.cmd [[autocmd BufWritePost,FileWritePost *.tex !latexmk -pdf]]
-- }}}
-- SLIME REPL {{{
vim.g.slime_bracketed_paste = 1
vim.g.slime_target = "tmux"

-- guess tmux pane
vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}" }

-- }}}
-- KEYBINDINGS {{{
vim.g.mapleader = " "

-- which key provides a nice menu to help remember hotkeys!
local wk = require("which-key")
wk.setup { triggers = { "<leader>" } }

-- plugin aliases
local telescope = require('telescope.builtin')
local quarto = require('quarto')
local lbuf = vim.lsp.buf

vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<Space>hp', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<Space>hs', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<Space>hu', '<Nop>', { noremap = true, silent = true })

local edit_snips = function()
  require("luasnip.loaders").edit_snippet_files({
    edit = function(file) vim.cmd("vsplit" .. file) end,
    extend = function(ft, paths)
      if #paths == 0 then
        return {
          { "$CONFIG/" .. ft .. ".snippets",
            string.format("%s/%s.snippets", "~/.config/nvim/snippets/", ft) }
        }
      end

      return {}
    end

  })
end

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
      a = { function() lbuf.code_action({ apply = true }) end, "code action" },
      d = { lbuf.definition, "goto definition (equivalent to C-[)" },
      f = { lbuf.format, "format buffer. (equivalent to Ggqg)" },
      i = { lbuf.implementation, "list implementations" },
      r = { lbuf.rename, "rename" },
      R = { lbuf.references, "list references" },
      s = { lbuf.signature_help, "view signature" },
      S = { lbuf.workspace_symbol, "view symbols in current workspace" },
      t = { lbuf.type_definition, "goto type definition" },
    },
    s = {
      name = "+snippets",
      e = { edit_snips, "edit snippets" }
    },
    h = { lbuf.hover, "open lsp hover window", noremap = true },
    q = {
      name = "+quarto",
      p = { quarto.quartoPreivew, "preview" }
    }
  },
})
-- }}}
