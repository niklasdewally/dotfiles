local bufnr = vim.api.nvim_get_current_buf()

local function nmap(key,fn,desc) 
vim.keymap.set('n',key,fn,{ buffer = bufnr , desc = desc, noremap= true, silent=true})
end

local function local_nmap(key,fn,desc) 
local prefix= "Rust: "
nmap('<LocalLeader>' .. key,fn,prefix..desc)
end

local_nmap('m',function() vim.cmd.RustLsp('expandMacro') end,'expand [m]acro')
local_nmap('d',function() vim.cmd.RustLsp('renderDiagnostic') end,'render [d]iagnostics')

