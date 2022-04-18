"
" Personal self-installing vim config using vim-plug.
"
"INSTALLATION:
" Rename this file .vimrc and place it in your home folder.
"
" On first run, the vim-plug plugin manager and plugins will be automatically
" installed into ~/.vim.
" 
" (if installing on the cs servers, you might need to mkdir
" /cs/home/<username>/.vim before doing this.)
"
" Written 19/11/21 by nd60
" Updated 31/12/21


set nocompatible " be vIM not vi!

""""""""""""""""""""""""""""""""""""
" Autoinstall vim-plug and plugins "
""""""""""""""""""""""""""""""""""""
" Copied from https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
" Best not to touch this!

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif


"""""""""""
" Plugins "
"""""""""""
" See: https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" PLACE PLUGINS HERE!
Plug 'morhetz/gruvbox' " my preferred colorscheme :)

"Personal Notetaking
Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " dependency for notational-fzf-...
Plug 'alok/notational-fzf-vim' " needs fzf and rg (ripgrep) installed
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'ferrine/md-img-paste.vim'
" Latex
Plug 'lervag/vimtex'
" Discord Rich Presence
Plug 'vimsence/vimsence'
" Readability 
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-airline/vim-airline' " nice bottom bar
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter' " show git diff info in airline
" Language Extras
Plug 'gregsexton/matchtag' " match HTML tags

call plug#end()
"""""""""""""""""
" Line Numbers  "
"""""""""""""""""
set ruler
"set nu 
" Use this if you want the current line to show the line number, but the
" others to show distance from the current line - this is useful for vim
" commands (eg 10j)!
set nu rnu


"""""""""""""""""""""""""""""""""""""""
" Indentation and Syntax Highlighting "
"""""""""""""""""""""""""""""""""""""""
" Uses vims default filetype settings - providing indentation and/or plugins.
" You can also make your own filetype plugins - see the docs and google for
" more deatails.
"
" See: :h filetype.

" Personal settings per filetype can be put in .vim/after/ftplugin/FILETYPE.vim
" Write these like any vimrc file, but use setlocal instead of set.
"
" See: :h filetype-plugins

syntax on
filetype plugin indent on

" Default, language agonostic tab/spaces indentation rules
" For most languages, this is personal preference, so not built into vim.
" (however, python uses pep8 defaults)

set autoindent " When indented, stay indented
set shiftwidth=4 " Number of characters to indent by
set tabstop=4 " Number of characters for tab key
set expandtab " Pressing tab makes 4 spaces.

"""""""""""""""""
" Colour-scheme "
"""""""""""""""""
" See the documentation for your preferred color-scheme for what to put here!
" for gruvbox (my scheme of choice): https://github.com/morhetz/gruvbox

set bg=dark " options: dark | light
colorscheme gruvbox
let g:airline_theme='gruvbox'

""""""""""""
" Markdown "
""""""""""""
" Automatically hide markdown syntax
let g:vim_markdown_conceal = 1
set conceallevel=2
" Format YAML frontmatter correctly
let g:vim_markdown_frontmatter = 1
" Format Strikethrough correctly
let g:vim_markdown_strikethrough = 1

" <Leader>p pastes current image into markdown buffer.
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
" there are some defaults for image directory and image name, you can change them
" let g:mdip_imgdir = 'img'
" let g:mdip_imgname = 'image'
"
" Automatically change into directory of the markdown file when opening -
" notational velocity does not do this automatically
autocmd FileType markdown setlocal autochdir
"""""""""""""""""""""""""""""""""""
" Notational Velocity / Searching "
"""""""""""""""""""""""""""""""""""
"
" This plugins implements :NV, which searches for files, or creates a new file
" if you cant find what you are looking for.

let g:nv_search_paths = ['~/notes','~/uni']
let g:nv_default_extension = '.md'

"""""""""""
" Vimwiki "  
"""""""""""
"
" Enable mouse control
let g:vimwiki_key_mappings = {'mouse':1,'lists_return':1}
let g:vimwiki_auto_chdir=1
" When opening a folder via [[cs1003/]], automatically enter the index of that folder
"let g:vimwiki_dir_link='index'

let g:vimwiki_tags_header = 'Tags'

" Define where our wiki is
" Automatically rebuild tag list on save - do this manually using :VimwikiRebuildTags
let g:vimwiki_list = [{'path': '~/notes/', 'syntax': 'markdown', 'ext': '.md', 'auto_tags': 1,'auto_toc': 1,'auto_generate_tags':1, 'auto_generate_links': 1, 'auto_diary_index': 1,'links_space_char': '_'}]
