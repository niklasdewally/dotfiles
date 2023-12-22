-- vim: cc=79
-- LSP, Completion, Snippets, ...

-- override settings here!
local servers = {
  clangd = {}
}

-- copied from kickstart:
-- Code ran when lsp servers attached
local function lsp_on_attach(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>r', vim.lsp.buf.rename, '[R]ename')
  nmap('<leader>c', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

return {
  { "simrat39/rust-tools.nvim", lazy = true, opts = {} },

  -- Set up completion and the snippet engine
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'honza/vim-snippets',
      'numToStr/Comment.nvim' -- i use this in my snippets
    },
    config = function(_, _)
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      -- first setup luasnip
      require('luasnip.loaders.from_vscode').lazy_load()
      require("luasnip.loaders.from_snipmate").lazy_load()
      require("luasnip.loaders.from_lua").lazy_load()

      -- username for use in todo snippet
      vim.g.snip_username = "niklasdewally"

      -- Make honza/vim-snippets work
      luasnip.filetype_extend("all", { "_" })

      luasnip.config.set_config({
        history = true,
        region_check_events = "CursorMoved,CursorHold,InsertEnter",
        -- fix https://github.com/L3MON4D3/LuaSnip/issues/116
        delete_check_events = 'TextChanged,InsertLeave',
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })


      -- Make honza/vim-snippets work
      luasnip.filetype_extend("all", { "_" })

      -- use snipmate format snippets
      -- store custom shipmate snippets in snippets/<filetype>.snippets
      -- this is easier than lua snippet syntax.
      -- By default, this installs any snippets/ folder found in runtime path
      require("luasnip.loaders.from_snipmate").lazy_load()

      -- load lua snippets
      -- stored in luasnippets folder
      require("luasnip.loaders.from_lua").lazy_load()

      -- then setup completion
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert',
          autocomplete = false
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<C-s>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
      })
    end
  },

  -- load all lsp, mason, mason-lspconfig, etc stuff in nvim-lspconfig's config function
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",                  -- completion engine
     { 'j-hui/fidget.nvim', opts = {} }, -- useful status stuf for lsp
    },
    config = function(_, _)
      require("mason").setup()
      require("mason-lspconfig").setup()

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- auto install servers
      -- see :h mason-lspconfig-automatic-server-setup
      require("mason-lspconfig").setup_handlers {
        function(server_name)    -- default handler
          require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            on_attach = lsp_on_attach,
            settings = servers[server_name]
          }
        end,

        -- override rust to use rusttools
        -- ["rust_analyzer"] = function ()
        --     require("rust-tools").setup {}
        -- end
      }
    end
  }
}
