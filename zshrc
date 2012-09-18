# set up rvm if installed
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

export EDITOR=vim
autoload -U compinit

# Build out a minimal, custom prompt
autoload -U colors
colors

escaped_red="%{${fg[red]}%}"
escaped_green="%{${fg[green]}%}"
escaped_reset="%{${reset_color}%}"

user_color="%(!.${escaped_red}.)"
exit_code_text="%(?.${escaped_green}.${escaped_red})%? ${escaped_reset}"
prompt_text="→ "

export PROMPT="${user_color}${exit_code_text}${prompt_text}${escaped_reset}"
source ~/dotfiles/zsh/prompt.zsh

# load a local override file if it exists
test -f $HOME/.zshrc.local && source $HOME/.zshrc.local

true
