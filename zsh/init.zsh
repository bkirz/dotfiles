# load rvm stuffs
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

NODE_PATH=/usr/local/lib/node

autoload -U compinit promptinit colors
promptinit
colors
 
alias ocaml="rlwrap ocaml"
alias coqtop="rlwrap coqtop"

user_color="%(!.%{${fg[red]}%}.%{${fg[green]}%})"

export PATH=$HOME/go/bin:$HOME/.bin:/opt/local/bin:$PATH:/usr/local/mysql/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/local/lib

export PROMPT="${user_color}[%{${reset_color}%}%m:%~${user_color}]%#%{${reset_color}%} "
export RPROMPT="${user_color}(%{${reset_color}%}%h - %*${user_color}%)%{${reset_color}%}"
export EDITOR=vim

setopt promptsubst
autoload -U promptinit
