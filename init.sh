#!/bin/sh

CONFPATH="$PWD/conf"

ln -sf $CONFPATH/.vimrc ~/.vimrc
ln -sf $CONFPATH/config.fish ~/.config/fish/
ln -sf $CONFPATH/.gitconfig ~/.gitconfig
ln -sf $CONFPATH/.gitignore_global ~/.gitignore_global
ln -sf $CONFPATH/.tmux.conf ~/.tmux.conf
ln -sf $CONFPATH/.bashrc ~/.bashrc

curl -fL https://raw.githubusercontent.com/eed3si9n/git-gone/master/git-gone -o /usr/local/bin/git-gone
chmod +x /usr/local/bin/git-gone

# for fish
curl -fL --create-dirs https://raw.githubusercontent.com/docker/cli/master/contrib/completion/fish/docker.fish -o ~/.config/fish/completions/docker.fish
curl -fL --create-dirs https://raw.githubusercontent.com/docker/compose/master/contrib/completion/fish/docker-compose.fish -o ~/.config/fish/completions/docker-compose.fish

# vimplug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# nvim
mkdir -p ~/.config/nvim
ln -sf $CONFPATH/init.vim ~/.config/nvim/init.vim
