-- jira syntax highlighting

loadPlugins({"https://github.com/s3rvac/vim-syntax-jira"})

-- open any file named .bee-jira in jira filetype.
--
-- I have configured the Browser External Editor plugin to create files with
-- this suffix. Any file with this suffix can be assumed to come from BEE.
--
-- https://github.com/rosmanov/chrome-bee/wiki/Configuration-in-Firefox
vim.cmd([[
let s:opened_file_path = expand('%:p')
if s:opened_file_path =~ '.*\.bee-jira'
    augroup firefox_chromebee_plugin
    autocmd!
    " Enable Jira syntax highlighting.
    autocmd BufRead,BufNewFile * setl ft=jira
    " (Optional) Enable English spell checking.
    autocmd BufRead,BufNewFile * setl spell spelllang=en
    augroup end
endif
]])
