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
let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="low"
colorscheme solarized

" Display bad whitespace
set listchars=tab:>-,trail:~
set list

" Allow list to be toggled easily
nmap <leader>l :set list!<CR>

" Display line numbers
set number

" Indentation preferences
set autoindent
set smartindent
set expandtab
set softtabstop=2
set shiftwidth=2
set nosmarttab

" Turn on virtual editing in block mode only
set virtualedit=block

" Force the active window to be wide enough for
" most reasonable codebases.
set winwidth=100

" Rather than setting paste/nopaste manually,
" define a function to auto-paste whatever's in the pasteboard
fun! PasteFromPasteBoard()
  set paste
  r!pbpaste
  set nopaste
endfun

nmap <leader>p :call PasteFromPasteBoard()<CR>


" Open NerdTREE by default
autocmd vimenter * NERDTree

" Close vim if NerdTREE is the only active buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Remove NerdTREE boilerplace
let NERDTreeMinimalUI=1

" Delegate to a local vimrc
if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif
