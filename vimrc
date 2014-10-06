" The little vimrc that could

" Disable crippling vi compatibility mode
set nocompatible

" Required for vundle config
filetype off

"""" BEGIN Vundle configuration
set rtp+=~/.vim/bundle/vundle
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'mileszs/ack.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'plasticboy/vim-markdown'
Plugin 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'elixir-lang/vim-elixir'

call vundle#end()
filetype plugin indent on
"""" END Vundle configuration

" Configure system clipboard
set clipboard=unnamed

" Make backspace work again
set backspace=indent,eol,start

" Enable pathogen (https://github.com/tpope/vim-pathogen)
call pathogen#infect()

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
set winwidth=90

" taken from: http://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim/1618401#1618401
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" command to strip white space from any file
nnoremap <leader>w :call <SID>StripTrailingWhitespaces()<cr>

" Rather than setting paste/nopaste manually,
" define a function to auto-paste whatever's in the pasteboard
fun! PasteFromPasteBoard()
  set paste
  r!pbpaste
  set nopaste
endfun

nmap <leader>p :call PasteFromPasteBoard()<CR>

" Remove NerdTREE boilerplace
let NERDTreeMinimalUI=1

" RSpec test helpers.
" Originals from Gary Bernhardt's screen cast:
" https://www.destroyallsoftware.com/screencasts/catalog/file-navigation-in-vim
" https://www.destroyallsoftware.com/file-navigation-in-vim.html
" Modified by Myron Marston:
" https://github.com/myronmarston/vim_files
function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo
    let rspec_bin = FindRSpecBinary(".")
    exec ":!time NOEXEC=0 " . rspec_bin . a:filename " --backtrace"
endfunction

function! FindRSpecBinary(dir)
  if filereadable(a:dir . "/bin/rspec")
    return a:dir . "/bin/rspec "
  elseif filereadable(a:dir . "/.git/config")
    " If there's a .git/config file, assume it is the project root;
    " Just run the system-gem installed rspec binary.
    return "rspec "
  else
    " We may be in a project sub-dir; check our parent dir
    return FindRSpecBinary(a:dir . "/..")
  endif
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_spec_file = match(expand("%"), '_spec.rb$') != -1
    if in_spec_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

" Run this file
map <leader>m :call RunTestFile()<cr>
" Run this file with the debugger loaded
map <leader>b :call RunTestFile(' -rdebugger')<cr>
" Run this file as a dry run (just emit example docstrings)
map <leader>d :call RunTestFile(' --dry-run')<cr>

" Search for the currently selected text using ack.vim
map <leader>a :Ack <c-R><cr>

" Set the current filetype to ruby
map <leader>r :set ft=ruby<cr>

" Ctrl-P configuration
let g:ctrlp_custom_ignore = { 'dir': '\v[\/](\.bundle|bundle|coverage|\.git|log)$' }

set wildignore+=*.swp

" Delegate to a local vimrc
if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif
