set -e
set -x

echo ========================
echo ========================
echo   Downloading Homebrew
echo ========================
echo ========================

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo ========================
echo ========================
echo     Installing tmux
echo ========================
echo ========================

brew install tmux

echo ========================
echo ========================
echo     Installing asdf
echo ========================
echo ========================

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.4.3

autoload -Uz compinit && compinit

echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.zshrc
echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc

echo ===========================
echo ===========================
echo   Installing asdf plugins
echo ===========================
echo ===========================

asdf plugin-add erlang
asdf plugin-add elixir
asdf plugin-add ruby
