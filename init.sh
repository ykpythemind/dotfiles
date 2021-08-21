#!/bin/sh

CONFPATH="$PWD"

echo "* symlink"
ln -sf $CONFPATH/.vimrc ~/.vimrc
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
ln -sf $CONFPATH/.zprofile ~/.zprofile

echo "* git-gone"
curl -fL https://raw.githubusercontent.com/eed3si9n/git-gone/master/git-gone -o /tmp/git-gone
sudo cp /tmp/git-gone /usr/local/bin/git-gone
sudo chmod +x /usr/local/bin/git-gone

echo "* zsh"
mkdir -p ~/.zsh/completion
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose --version | awk 'NR==1{print $NF}')/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose

echo "* vimplug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "* neovim"
mkdir -p ~/.config/nvim
ln -sf $CONFPATH/init.vim ~/.config/nvim/init.vim
ln -sf $CONFPATH/coc-settings.json ~/.config/nvim/coc-settings.json

mkdir -p ~/.cache/shell

echo "* deno"
mkdir ~/.zsh/completion # create a folder to save your completions. it can be anywhere
deno completions zsh > ~/.zsh/completion/_deno

echo "* ruby"
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git -C ${HOME}/.rbenv pull
mkdir -p ~/.rbenv/plugins
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
git -C ${HOME}/.rbenv/plugins/ruby-build pull
git clone https://github.com/rbenv/rbenv-default-gems.git ~/.rbenv/plugins/rbenv-default-gems
git -C ${HOME}/.rbenv/plugins/rbenv-default-gems pull
ln -sf $CONFPATH/default_gems ~/.rbenv/default-gems

echo "* link diff-highlight"
sudo ln -s `brew --prefix git`/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight

echo "zsh / pure"
mkdir -p ${HOME}/.zsh
git clone https://github.com/sindresorhus/pure.git ${HOME}/.zsh/pure
git -C ${HOME}/.zsh/pure pull

echo "* kitty"
mkdir -p ${HOME}/.config/kitty
ln -sf $CONFPATH/kitty.conf ~/.config/kitty/kitty.conf

echo "* go"
go install golang.org/x/tools/cmd/goimports@latest
