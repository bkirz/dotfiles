" The little vimrc that could

" Disable crippling vi compatibility mode
set nocompatible

" Required for vundle config
filetype off

"""" BEGIN Vundle configuration
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'mileszs/ack.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'plasticboy/vim-markdown'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-surround'
Plugin 'cespare/vim-toml'
Plugin 'wting/rust.vim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'keith/swift.vim'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'elixir-lang/vim-elixir'

" I think this is messing with my indentation
" Plugin 'slashmili/alchemist.vim'

" I _really_ want this, but it's so slow.
" Plugin 'Valloric/YouCompleteMe'

call vundle#end()
filetype plugin indent on
"""" END Vundle configuration

" Configure system clipboard
" set clipboard=unnamed

" Disable vim-markdown's folding support
let g:vim_markdown_folding_disabled=1

" Make backspace work again
set backspace=indent,eol,start

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
" set winwidth=81

" Recognize those stupid non-extension python files in pebble projects
autocmd BufNewFile,BufRead wscript set filetype=python

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

" Test runner helpers.
" Originals from Gary Bernhardt's screen cast:
" https://www.destroyallsoftware.com/screencasts/catalog/file-navigation-in-vim
" https://www.destroyallsoftware.com/file-navigation-in-vim.html
" Modified by Myron Marston:
" https://github.com/myronmarston/vim_files
function! RunTests(filename, env_vars)
    " Write the file and run tests for the given filename
    :w

    let is_mix_project = filereadable("./mix.exs")
    let is_elixir = match(a:filename, '_test.exs$') != -1
    let is_python = match(a:filename, '.py$') != -1
    let is_lua_spec = match(a:filename, 'spec.lua$') != -1

    if !is_python
      :silent !echo;echo;echo;
    end

    if is_python
      call Send_to_Tmux("time py.test " . a:filename . "\n")
    elseif is_mix_project
      " cd into app directory one folder above test dir
      let path_parts = split(a:filename, 'test.*')
      if path_parts == []
        " We are in the right directory, so don't change dirs.
        exec ":!time mix test " . a:filename . " --trace"
      else
        let path = path_parts[0]
        let test_file = split(a:filename, l:path)[0]
        exec ":! pushd " . l:path . "; time mix test " . l:test_file . " --trace; popd"
      endif
    elseif is_elixir
      exec ":!time elixir " . a:filename
    elseif is_lua_spec
      " Assume we're using the busted framework, since that's what exercism
      " uses.
      exec ":!time busted " . a:filename
    else
      " Assume we're using rspec.
      let rspec_bin = FindRSpecBinary(".")
      exec ":!time NOEXEC=0 " . a:env_vars . rspec_bin . a:filename
    end
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

function! ConditionallySetTestFile()
    let in_spec_file   = match(expand("%"), '_spec.rb$') != -1
    let in_elixir_file = match(expand("%"), '_test.exs$') != -1
    let in_python_test_file = match(expand("%"), 'test.\+\.py$') != -1

    if in_spec_file || in_elixir_file || in_python_test_file
        call SetTestFile()
    end
endfunction

function! RunTestFile(command_suffix, env_vars)
    call ConditionallySetTestFile()

    if !exists("t:grb_test_file")
        exec "!echo 'No test file set'"
        return
    end

    call RunTests(t:grb_test_file . a:command_suffix, a:env_vars)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number, "")
endfunction
" Run only the example under the cursor
map <leader>. :call RunNearestTest()<cr>

function! RunTestFileWithDebugger()
    call RunTestFile(' -rdebugger', "")
endfunction
map <leader>b :call RunTestFileWithDebugger()<cr>

function! RunNextFailureWithDebugger()
    call RunTests('spec -rdebugger --next-failure', '')
endfunction
map <leader>f :call RunNextFailureWithDebugger()<cr>

function! RunTestFileWithoutDebugger()
    call RunTestFile('', "")
endfunction
" Run this file
map <leader>m :call RunTestFileWithoutDebugger()<cr>

" Run all test files -- not used for now
" map <leader>a :call RunTests('spec')<cr>


" Search for the currently selected text using ack.vim
map <leader>a :Ack <c-R><cr>

" Set the current filetype to ruby
map <leader>r :set ft=ruby<cr>

" Ctrl-P configuration
let g:ctrlp_custom_ignore = { 'dir': '\v[\/](\.bundle|bundle|coverage|logs?|_build|deps|tmp\/travis)$', 'file': '\v\.(beam|html)$' }
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']


set wildignore+=*.swp

" Delegate to a local vimrc
if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif


" Configure vagrantfiles as ruby files
augroup vagrant
  au!
  au BufRead,BufNewFile Vagrantfile set filetype=ruby
augroup END
