" The little vimrc that could

" Disable crippling vi compatibility mode
set nocompatible

" Enable pathogen (https://github.com/tpope/vim-pathogen)
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Enable syntax highlighting
syntax on
filetype plugin on

" Use the dark version of the solarized theme
set background=light
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="low"
colorscheme solarized

" Display whitespace
set listchars=tab:>-,trail:~
set list

" Indentation preferences
set autoindent
set smartindent
set nowrap
set expandtab
set softtabstop=2
set shiftwidth=2
set nosmarttab
set virtualedit=block
