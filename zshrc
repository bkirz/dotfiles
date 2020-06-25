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

# Bind to emacs keymaps (vi mode is half-baked)
bindkey -e

# Let's try out neovim for a bit
# alias vim="nvim"

# Load tab-completion config
autoload -U compinit
compinit

# Ensure homebrew-installed stuff takes precedence over system
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Load a local override file for machine-specific config
[[ -s $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

# Enable extremely powerful extended globbing features
# described here: http://zsh.sourceforge.net/Intro/intro_2.html
setopt extendedglob

# added by travis gem
[ -f /Users/benjamin/.travis/travis.sh ] && source /Users/benjamin/.travis/travis.sh

[ -f $HOME/.asdf/asdf.sh ] && source $HOME/.asdf/asdf.sh

[ -f $HOME/.asdf/completions/asdf.bash ] && source $HOME/.asdf/completions/asdf.bash
