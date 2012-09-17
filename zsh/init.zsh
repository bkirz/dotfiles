# load rvm stuffs
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

autoload -U compinit promptinit colors
promptinit
colors

escaped_red="%{${fg[red]}%}"
escaped_green="%{${fg[green]}%}"
escaped_reset="%{${reset_color}%}"

user_color="%(!.${escaped_red}.)"
exit_code_text="%(?.${escaped_green}.${escaped_red})%? ${escaped_reset}"
prompt_text="→ "

export PROMPT="${user_color}${exit_code_text}${prompt_text}${escaped_reset}"

export EDITOR=vim
export PATH=$HOME/.bin:/usr/local/bin:/usr/local/sbin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/local/lib

setopt promptsubst
autoload -U promptinit
