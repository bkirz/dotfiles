fpath=($fpath $HOME/.zsh/func)
typeset -U fpath

setopt prompt_subst
autoload -U promptinit
promptinit
prompt bkirz

export EDITOR=vim

autoload -U compinit
compinit

# set up rvm if installed
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

# load a local override file if it exists
test -f $HOME/.zshrc.local && source $HOME/.zshrc.local

true
