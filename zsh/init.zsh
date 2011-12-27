# load rvm stuffs
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

autoload -U compinit promptinit colors
promptinit
colors

user_color="%(!.%{${fg[red]}%}.)"

export PATH=$HOME/.bin:/usr/local/bin:/usr/local/sbin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/local/lib

export PROMPT="${user_color}[%{${reset_color}%}%m:%~${user_color}]%#%{${reset_color}%} "
export EDITOR=vim

setopt promptsubst
autoload -U promptinit
