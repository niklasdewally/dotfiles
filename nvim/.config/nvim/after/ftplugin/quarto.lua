-- run code blocks with vim slime
local runner = require("quarto.runner")

local wk = require("which-key")

wk.add({
  {"<localleader>r", group = "[r]un"}
})

vim.keymap.set("n", "<localleader>rc", runner.run_cell,  { desc = "[r]un cell", silent = true })
vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "[r]un cell and [a]bove", silent = true })
vim.keymap.set("n", "<localleader>rA", runner.run_all,   { desc = "[r]un [a]ll cells", silent = true })
vim.keymap.set("n", "<localleader>rl", runner.run_line,  { desc = "[r]un [l]ine", silent = true })
vim.keymap.set("v", "<localleader>rr",  runner.run_range, { desc = "[r]un visual [r]ange", silent = true })
vim.keymap.set("n", "<localleader>rL", function()
  runner.run_all(true)
end, { desc = "[r]un all cells of all languages", silent = true })
