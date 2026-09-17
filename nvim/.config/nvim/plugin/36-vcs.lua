-- git related plugins

loadPlugins({
  -- :Git and lots of good stuff
  "https://github.com/tpope/vim-fugitive",

  -- Resolve merge conflicts as a diff 
  "https://github.com/whiteinge/diffconflicts",

  -- add git diff signs to the gutter
  "https://github.com/lewis6991/gitsigns.nvim",

  -- add jj diff signs to the gutter
  "https://github.com/evanphx/jjsigns.nvim",

  -- also gutter signs for jj using mini.diff
  "https://tangled.org/ronshavit.com/mini.diff.jj"
})

-- use mini.diff for gutter signs instead of gitsigns, as I can add jj as a backend too.
local diff = require("mini.diff")
diff.setup({
  -- Options for how hunks are visualized
  view = {
    -- Visualization style. Possible values are 'sign' and 'number'.
    -- Default: 'number' if line numbers are enabled, 'sign' otherwise.
    style = vim.go.number and 'number' or 'sign',

    -- Signs used for hunks with 'sign' view
    signs = { add = '▒', change = '▒', delete = '▒' },

    -- Priority of used visualization extmarks
    priority = 199,
  },

  -- Source(s) for how reference text is computed/updated/etc
  -- Uses content from Git index by default
    sources = {require("mini.diff.jj"),diff.gen_source.git()},

  -- Delays (in ms) defining asynchronous processes
  delay = {
    -- How much to wait before update following every text change
    text_change = 200,
  },

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Apply hunks inside a visual/operator region
    apply = 'gh',

    -- Reset hunks inside a visual/operator region
    reset = 'gH',

    -- Hunk range textobject to be used inside operator
    -- Works also in Visual mode if mapping differs from apply and reset
    textobject = 'gh',

    -- Go to hunk range in corresponding direction
    goto_first = '[H',
    goto_prev = '[h',
    goto_next = ']h',
    goto_last = ']H',
  },

  -- Various options
  options = {
    -- Diff algorithm (see `:h vim.text.diff()`)
    algorithm = 'histogram',

    -- Whether to use "indent heuristic" (see `:h vim.text.diff()`)
    indent_heuristic = true,

    -- The amount of second-stage diff to align lines
    linematch = 60,

    -- Whether to wrap around edges during hunk navigation
    wrap_goto = false,
  },
})

-- NOTE: with mini.diff, ]h [h to nativate hunks, not [g ]g

-- require('gitsigns').setup({
--   on_attach = function(bufnr)
--     vim.keymap.set("n","]g",
--       function() require("gitsigns").nav_hunk("next") end,{desc = "Next git hunk", buffer = bufnr})
--
--     vim.keymap.set("n","[g",
--       function() require("gitsigns").nav_hunk("prev") end,{desc = "Previous git hunk", buffer = bufnr})
-- end})
--
-- require('jjsigns').setup({
--   enabled = true,
--
--   attach = {
--     auto = true,  -- Auto-attach to JJ repository files
--   },
--
--   signs = {
--     add = { text = '┃', numhl = 'JjSignsAddNr', linehl = 'JjSignsAddLn' },
--     change = { text = '┃', numhl = 'JjSignsChangeNr', linehl = 'JjSignsChangeLn' },
--     delete = { text = '▁', numhl = 'JjSignsDeleteNr', linehl = 'JjSignsDeleteLn' },
--     topdelete = { text = '▔', numhl = 'JjSignsDeleteNr', linehl = 'JjSignsDeleteLn' },
--     changedelete = { text = '~', numhl = 'JjSignsChangeNr', linehl = 'JjSignsChangeLn' },
--   },
--
--   sign_priority = 6,
--   signcolumn = true,  -- Toggle with `:JjSigns toggle_signs`
--   numhl = false,      -- Toggle with `:JjSigns toggle_numhl`
--   linehl = false,     -- Toggle with `:JjSigns toggle_linehl`
--
--   -- JJ specific options
--   base = '@-',  -- Base revision to compare against (default: parent revision)
--
--   -- Performance options
--   update_debounce = 100,  -- Debounce time for updates in milliseconds
-- })
