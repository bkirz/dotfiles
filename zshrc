# Load custom functions
fpath=($fpath $HOME/.zsh/func)
typeset -U fpath

# Load custom prompt
setopt prompt_subst
autoload -U promptinit
promptinit
prompt bkirz

# Use vim by default
export EDITOR=vim

# Load tab-completion config
autoload -U compinit
compinit

# Load rvm if installed
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

# Load a local override file for machine-specific config
[[ -s $HOME/.zshrc.local ]] && source $HOME/.zshrc.local
