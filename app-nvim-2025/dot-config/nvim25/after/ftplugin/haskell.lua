local ht = require('haskell-tools')
local bufnr = vim.api.nvim_get_current_buf()

local function nmap(key,fn,desc) 
  vim.keymap.set('n',key,fn,{ buffer = bufnr , desc = desc, noremap= true, silent=true})
end

local function local_nmap(key,fn,desc) 
  local prefix= "Haskell: "
  nmap('<LocalLeader>' .. key,fn,prefix..desc)
end

-- haskell-language-server relies heavily on codeLenses,
-- so auto-refresh (see advanced configuration) is enabled by default

local_nmap('cl', vim.lsp.codelens.run, '[c]ode [l]enses')

-- Hoogle search for the type signature of the definition under the cursor
local_nmap('hs', ht.hoogle.hoogle_signature,'[h]oogle [s]ignature')

-- Evaluate all code snippets
local_nmap('ea', ht.lsp.buf_eval_all,'[e]valuate [a]ll code snippets')

-- Toggle a GHCi repl for the current package
local_nmap('rr', ht.repl.toggle, '[r]epl toggle (for package)')

-- Toggle a GHCi repl for the current buffer
local_nmap('rf', function() ht.repl.toggle(vim.api.nvim_buf_get_name(0)) end, '[r]epl toggle (for buffer)')

local_nmap('rq',ht.repl.quit,'[r]epl [q]uit')

