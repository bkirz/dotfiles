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

# Ensure homebrew-installed stuff takes precedence over system
export PATH="/usr/local/bin:$PATH"

# Load chruby and enable auto-switching
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

# Load a local override file for machine-specific config
[[ -s $HOME/.zshrc.local ]] && source $HOME/.zshrc.local
