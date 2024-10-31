-- vim: cc=80

-- Highlight, edit, and navigate code with treesitter.
--
-- Highlighting by treesitter itself, selection stuff with 
-- treesitter-text-subjects:
-- https://github.com/RRethy/nvim-treesitter-textsubjects
-- (see kickstart.nvim)

local function inspect_treesitter_lang()
    vim.ui.input({ prompt = "Enter language: " }, function(lang)
      info = vim.inspect(vim.treesitter.language.inspect(lang))

      -- invisible scratch buffer and floating window
      buf = vim.api.nvim_create_buf(false,true)

      local result = {};
      for line in string.gmatch(info.. "\n", "(.-)\n") do
          table.insert(result, line);
      end

      vim.api.nvim_buf_set_lines(buf,0,0,false,result)
      window = vim.api.nvim_open_win(buf,true,{win=-1,split="below"})
    end)
end

-- treesitter debugging bindings
vim.keymap.set('n',"<Leader>Tl",inspect_treesitter_lang,{desc="[T]reesitter inspect [l]ang"})
vim.keymap.set('n',"<Leader>Ti",vim.treesitter.inspect_tree,{desc="[T]reesitter [i]nspect tree"})

return {
  {'nvim-treesitter/nvim-treesitter',
    -- on first install, also install all the treesitter parsers
    build = ':TSUpdate',
    dependencies = {'RRethy/nvim-treesitter-textsubjects'},
    main = 'nvim-treesitter.configs',
    opts = {
      sync_install = true, -- install parsers synchronously
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      textsubjects = {
        enable = true,
        prev_selection = ',', -- (Optional) keymap to select the previous selection
        keymaps = {
          ['.'] = 'textsubjects-smart',
          [';'] = 'textsubjects-container-outer',
          ['i;'] = { 'textsubjects-container-inner', desc = "Select inside containers (classes, functions, etc.)" },
        },
      },
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
        "html",
        'javascript',
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
        'vim'
      }
    },
  },
}

