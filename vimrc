" The little vimrc that could

" Disable crippling vi compatibility mode
set nocompatible

" Make backspace work again
set backspace=indent,eol,start

" Enable pathogen (https://github.com/tpope/vim-pathogen)
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Use comma for Leader (easier to type than backslash)
let mapleader = ","

" Enable syntax highlighting
syntax on
filetype plugin on
filetype indent on

" Use the dark version of the solarized theme
set bg=dark
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="low"
colorscheme solarized

" Display whitespace
set listchars=tab:>-,trail:~
set list

" Display line numbers
set nu

" Set and highlight 80-column boundary
set textwidth=79
set colorcolumn=+0,+1,+2

" Indentation preferences
set autoindent
set smartindent
set expandtab
set softtabstop=2
set shiftwidth=2
set nosmarttab
set virtualedit=block
