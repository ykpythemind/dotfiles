#!/bin/sh

CONFPATH="$PWD"

echo "* symlink"
ln -sf $CONFPATH/.vimrc ~/.vimrc
ln -sf $CONFPATH/config.fish ~/.config/fish/
ln -sf $CONFPATH/.gitconfig ~/.gitconfig
ln -sf $CONFPATH/.gitignore_global ~/.gitignore_global
ln -sf $CONFPATH/.tmux.conf ~/.tmux.conf
ln -sf $CONFPATH/.bashrc ~/.bashrc
ln -sf $CONFPATH/.ignore ~/.ignore
ln -sf $CONFPATH/.ignore ~/.agignore
ln -sf $CONFPATH/.alacritty.yml ~/.alacritty.yml
ln -sf $CONFPATH/.editorconfig ~/.editorconfig
ln -sf $CONFPATH/.tigrc ~/.tigrc
ln -sf $CONFPATH/.zshrc ~/.zshrc

echo "* git-gone"
curl -fL https://raw.githubusercontent.com/eed3si9n/git-gone/master/git-gone -o /usr/local/bin/git-gone
chmod +x /usr/local/bin/git-gone

echo "* fish"
curl -fL --create-dirs https://raw.githubusercontent.com/docker/cli/master/contrib/completion/fish/docker.fish -o ~/.config/fish/completions/docker.fish
curl -fL --create-dirs https://raw.githubusercontent.com/docker/compose/master/contrib/completion/fish/docker-compose.fish -o ~/.config/fish/completions/docker-compose.fish

echo "* vimplug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "* neovim"
mkdir -p ~/.config/nvim
ln -sf $CONFPATH/init.vim ~/.config/nvim/init.vim
ln -sf $CONFPATH/coc-settings.json ~/.config/nvim/coc-settings.json

mkdir -p ~/.cache/shell

echo "* link diff-highlight"

ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight

echo "zsh / pure"
mkdir -p ${HOME}/.zsh
git clone https://github.com/sindresorhus/pure.git ${HOME}/.zsh/pure
git -C ${HOME}/.zsh/pure pull

