--- Miscellaneous tools for editing hledger journal files.
---
--- Requirements: 
---   - nvim 0.12 or above
---   - nvim-treesitter (master branch)
---   - the ledger grammar to be installed via nvim-treesitter


local M = {}

---@alias TopLevelWhitespace {kind: "top_level_whitespace", contents: string, original_start_row: integer}
---@alias OtherJournalItem {kind: "not_xact", contents: string, original_start_row: integer}
---@alias PlainXact {kind: "plain_xact", contents: string, date: string, original_start_row: integer}
---@alias AutomatedXact {kind: "automated_xact", contents: string, original_start_row: integer}
---@alias PeriodicXact {kind: "periodic_xact", contents: string, original_start_row: integer}
---
---
---@alias JournalEntry
--- | TopLevelWhitespace
--- | OtherJournalItem
--- | PlainXact
--- | AutomatedXact
--- | PeriodicXact

-- Sort the given list of journal entries by date, and original position
--
-- Asserts that the given JournalEntry has the correct fields
---@param entry(JournalEntry)
local function assertValidJournalEntry(entry)
  assert(entry["kind"], "expect all journal entrys to have a kind")
  assert(entry["contents"], "expect all journal entrys to have contents")
  assert(entry["original_start_row"], "expect all journal entrys to have stored their original start row number")
  assert((entry["kind"] == "plain_xact" and entry["date"] or true),
    "expect all plain_xact journal entries to have dates")
end

--- Parses the current buffer into a list of journal entries ready for sorting.
---
---@return [JournalEntry]
local function parseJournalEntries()
  local query = vim.treesitter.query.get("ledger", "sort")
  assert(query ~= nil, "expect query ledger/sort.scm to exist")

  local tree = vim.treesitter.get_parser():parse(true)[1]

  local journal_entries = {}

  for _, match, metadata in query:iter_matches(tree:root(), 0, 0, -1) do
    local curr_entry = { kind = metadata["kind"] }

    -- extract information from captures
    for id, nodes in pairs(match) do
      local capture_name = query.captures[id]
      assert(#nodes == 1, "expect to only have a single node for each capture")
      local node = nodes[1]
      local node_text = vim.treesitter.get_node_text(node, 0)

      if capture_name == "node" then
        local row1, _, _, _ = node:range() -- range of the capture
        curr_entry["original_start_row"] = row1
        curr_entry["contents"] = node_text
      elseif capture_name == "date" then
        assert(curr_entry.kind == "plain_xact", "expect a date capture only for node kind plain_xact")
        curr_entry["date"] = node_text
      elseif capture_name == "_node" then
        -- this is a query-internal capture used for predicates. ignore.
      else
        error("Unexepcted capture name while parsing journal: " .. capture_name)
      end
    end

    assertValidJournalEntry(curr_entry)

    table.insert(journal_entries, curr_entry)
  end

  return journal_entries
end

---@param entries [JournalEntry]
---@return [JournalEntry]
local function sortJournalEntries(entries)
  -- To avoid messing up the file, require that all non plain_xact entries appear before the first plain_xact entry.
  -- Then, return the non plain_xact entries verbatim, and sort the plain_xact entries.

  local other_entries = {}
  local plain_xact_entries = {}

  local parsed_any_plain_xact = false

  for _, entry in ipairs(entries) do
    if entry["kind"] == "plain_xact" then
      parsed_any_plain_xact = true
      table.insert(plain_xact_entries, entry)
    elseif not parsed_any_plain_xact then
      table.insert(other_entries, entry)
    elseif parsed_any_plain_xact and (entry["kind"] ~= "top_level_whitespace") then
      -- swallow whitespace when parsing plain_xacts, error on other entries
      error("expect no non-plain transaction entries after a plain transaction entry has been parsed... on line " ..
        entry["original_start_row"] .. "  kind " .. entry["kind"])
    end
  end


  table.sort(plain_xact_entries,
    function(a, b) return (a.date == b.date) and (a.original_start_row < b.original_start_row) or (a.date < b.date) end)

  -- combine tables, addd whitespace between each plain_xact entry for prettyness
  for _, entry in ipairs(plain_xact_entries) do
    table.insert(other_entries, entry)
    table.insert(other_entries, { kind = "top_level_whitespace", contents = "\n", original_start_row = -1 })
  end

  return other_entries
end


--- Sorts, in place, the journal file in the current buffer by date and original location in the file.
---
--- By sorting journal entries with the same date by their original ordering in the file, we ensure that value assertions still work.
---
--- This function fails if after the first transaction, a non transaction journal entry is found (comments, declarations, etc).
function M.sortBuffer()
  local file_lines = {}
  for _, entry in ipairs(sortJournalEntries(parseJournalEntries())) do
    for line in string.gmatch(entry.contents, "([^\n]+)") do
      table.insert(file_lines, line)
    end

    -- preserve newline only entries,as the regex above swallows them
    if entry["kind"] == "top_level_whitespace" then
      table.insert(file_lines, "")
    end

  end

  vim.api.nvim_buf_set_text(0, 0, 0, -1, -1, file_lines)
end

return M
