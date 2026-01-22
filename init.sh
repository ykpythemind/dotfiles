#!/bin/sh

CONFPATH="$PWD"

echo "* symlink"
mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.config/direnv
mkdir -p $HOME/.claude

ln -sf $CONFPATH/.gitconfig ~/.gitconfig
ln -sf $CONFPATH/.gitignore_global ~/.gitignore_global
ln -sf $CONFPATH/.tmux.conf ~/.tmux.conf
ln -sf $CONFPATH/.ignore ~/.ignore
ln -sf $CONFPATH/.ignore ~/.agignore
ln -sf $CONFPATH/.zshrc ~/.zshrc
ln -sf $CONFPATH/.zprofile ~/.zprofile
ln -sf $CONFPATH/.vimrc ~/.vimrc
ln -sf $CONFPATH/.vimrc ~/.config/nvim/init.vim
ln -sf $CONFPATH/claude/settings.json ~/.claude/settings.json

echo "* git-gone"
curl -fL https://raw.githubusercontent.com/ykpythemind/git-gone/master/git-gone -o /tmp/git-gone
sudo cp /tmp/git-gone /usr/local/bin/git-gone
sudo chmod +x /usr/local/bin/git-gone

echo "* zsh"
mkdir -p ~/.zsh/completion
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose --version | awk 'NR==1{print $NF}')/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose

if [[ ! -f ${HOME}/.zplug ]]; then
  # https://github.com/zplug/zplug
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

which mise || echo "mise not found. please install it. https://mise.jdx.dev/getting-started.html"

echo "* vimplug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

mkdir -p ~/.vim/undo
mkdir -p ~/.cache/shell

echo "* ruby"
ln -sf $CONFPATH/default_gems ~/.default-gems

echo "* go"
go install golang.org/x/tools/cmd/goimports@latest

echo "* gh"
gh alias set --shell prcreate 'gh pr view -w || gh pr create -w'
gh extension install seachicken/gh-poi
