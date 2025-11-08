-- custom telescope pickers

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local conf = require("telescope.config").values
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local previewers = require "telescope.previewers"

local make_entry = require("telescope.make_entry")
local M = {}

-- TODO: search git log content too (a la https://github.com/aaronhallaert/advanced-git-search.nvim/tree/main/lua/advanced_git_search/fzf/finders)
-- (this will require a new entry_maker)
--
-- https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md

-- TODO: search by current file
-- TODO: display things in git log --pretty=reference format.
--  1. change git command to use --pretty=reference
--  2. make custom entry maker to process it

--- Searches for a git git commit, saving a reference to the selected one to the clipboard and the r register.
---
--- @param opts table: options to pass to the picker
M.git_ref = function(opts)
  -- based on builtin git commit picker
  -- see:
  --  + https://github.com/nvim-telescope/telescope.nvim/blob/b4da76be54691e854d3e0e02c36b0245f945c2c7/lua/telescope/builtin/init.lua#L163
  --  + https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/builtin/__git.lua#L67
  opts = opts or {}
  opts.entry_maker = opts.entry_maker or make_entry.gen_from_git_commits(opts)
  opts.git_command = opts.git_command or {"git","log","--pretty=oneline", "--abbrev-commit"}
  pickers.new(opts, {
    prompt_title = "git ref",
    finder = finders.new_oneshot_job(opts.git_command,opts),
    previewer = {
      previewers.git_commit_message.new(opts),
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry().value
        local obj = vim.system({"git","show","--no-patch","--pretty=reference","--abbrev-commit",selection}):wait()
        local output = obj.stdout
        vim.fn.setreg("",output)
        vim.fn.setreg("r",output)
      end)
      return true
    end}):find()
  end



  return M
