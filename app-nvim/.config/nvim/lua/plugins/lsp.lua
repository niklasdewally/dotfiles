-- vim: cc=79
-- LSP, Completion, Snippets, ...

-- override settings here!
local servers = {
}

-- copied from kickstart:
-- Code ran when lsp servers attached
--
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
  require('otter').activate({'python','r','rust'}, true, true,nil)
  vim.lsp.inlay_hint.enable(true,{bufnr=bufnr})

end

local function rust_on_attach(_,bufnr) 

  vim.keymap.set('n','<LocalLeader>rm','<cmd>RustLsp expandMacro<CR>', { buffer = bufnr, desc =  'expand [m]acro'})
  lsp_on_attach(_,bufnr)
end

return {

  -- Completion and the snippet engine.
  {"hrsh7th/nvim-cmp",
    dependencies = {
      'hrsh7th/cmp-path',           -- complete paths.
      'kirasok/cmp-hledger', -- hledger
      --'hrsh7th/cmp-cmdline',        -- complete vim : commands.
      'hrsh7th/cmp-nvim-lsp',       -- complete from LSP.
      'jmbuhr/cmp-pandoc-references',
      'jmbuhr/otter.nvim',
      'L3MON4D3/LuaSnip',           -- snippet engine.
      'saadparwaiz1/cmp_luasnip',   -- complete from snippets.
      'numToStr/Comment.nvim',      -- I use this in my snippets
      'honza/vim-snippets',         -- snippet pack
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

      -- custom snippets
      require("luasnip.loaders.from_snipmate").lazy_load({paths="~/.snippets/snippets"})
      require("luasnip.loaders.from_lua").lazy_load({paths="~/.snippets/luasnippets"})

      vim.keymap.set('n', "<leader>Se", function() require("luasnip.loaders").edit_snippet_files({
	  extend = function(ft, paths)
	    if #paths == 0 then
	      return {
		{ ".snippets/" .. ft .. ".snippets",
		  string.format("~/.snippets/snippets/%s.snippets",ft)}
	      }
	    end

	    return {}
	  end
      }) end,
        { desc = "edit snippet files" })

      -- setup completion
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        completion = {
          --completeopt = 'menu,menuone,noinsert',
          autocomplete = false
        },

        mapping = cmp.mapping.preset.insert {
          -- NOTE: these are the standard vim keybindings for completion,
          -- so will come up in many places :)
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'otter' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'cmdline' },
          { name = 'pandoc_references' },
          { name = 'hledger' }
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
      "mrcjkb/rustaceanvim",
      "hrsh7th/nvim-cmp",                  -- completion engine
      { 'j-hui/fidget.nvim', opts = {} }, -- useful status stuf for lsp
    },
    config = function(_, _)
      require("mason").setup()
      require("mason-lspconfig").setup({ensure_installed = vim.tbl_keys(servers)})

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

        ["lua_ls"] = function ()
          require'lspconfig'.lua_ls.setup {
            on_attach = lsp_on_attach,
            on_init = function(client)
              local path = client.workspace_folders[1].name
              if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
                client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                  Lua = {
                    runtime = {
                      -- Tell the language server which version of Lua you're using
                      -- (most likely LuaJIT in the case of Neovim)
                      version = 'LuaJIT'
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                      checkThirdParty = false,
                      library = vim.api.nvim_get_runtime_file("", true)
                    }
                  }
                })
              end
              return true
            end
          }
        end,
        -- override rust to never use lsp
        ["rust_analyzer"] = function ()
        end
      }
    end
  },

  -- rust!!
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
    init = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach= rust_on_attach 
        }}
    end
  }

}
