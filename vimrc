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
" Run only the example under the cursor
map <leader>. :call RunNearestTest()<cr>
" Run all test files
map <leader>a :call RunTests('spec')<cr>

" Delegate to a local vimrc
if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif
