#!/bin/sh

ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.zshenv ~/.zshenv
ln -sf ~/dotfiles/.zprofile ~/.zprofile
ln -sf ~/dotfiles/.screenrc ~/.screenrc
ln -sf ~/dotfiles/config.fish ~/.config/fish/
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.gitignore_global ~/.gitignore_global
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

curl -fL --create-dirs https://raw.githubusercontent.com/docker/cli/master/contrib/completion/fish/docker.fish -o ~/.config/fish/completions/docker.fish
curl -fL --create-dirs https://raw.githubusercontent.com/docker/compose/master/contrib/completion/fish/docker-compose.fish -o ~/.config/fish/completions/docker-compose.fish
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
