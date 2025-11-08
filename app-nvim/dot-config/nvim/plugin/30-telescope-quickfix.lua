-- telescope / quickfix setup
--
-- TODO: add some extensions https://github.com/nvim-telescope/telescope.nvim/wiki/Extensions#different-plugins-with-telescope-integration
--
-- See also:
--   * 12-keybinds.lua for pickers in use

-- run build-script for telescope-fzf-native on install
local hooks = function(ev)
  -- Use available |event-data|
  local name, kind = ev.data.spec.name, ev.data.kind

  -- Run build script after plugin's code has changed
  if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
    vim.system({ 'make' }, { cwd = ev.data.path })
  end
end

-- If hooks need to run on install, run this before `vim.pack.add()`
vim.api.nvim_create_autocmd('PackChanged', { callback = hooks })

vim.pack.add({
  { src = "https://github.com/nvim-telescope/telescope.nvim",           version = "master"},
  { src = "https://github.com/nvim-lua/plenary.nvim"},
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
})

require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ['C-h'] = "which_key",
        ['C-q'] = "smart_send_to_qflist",
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      }
    }
  },
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  }
})

require('telescope').load_extension('fzf')

-- nvim-pqf: nicer quickfix box
vim.pack.add({"https://github.com/yorickpeterse/nvim-pqf"})
require('pqf').setup()
