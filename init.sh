#!/bin/sh

CONFPATH="$PWD"

echo "* symlink"
mkdir -p $HOME/.config/peco

ln -sf $CONFPATH/.vimrc ~/.vimrc
ln -sf $CONFPATH/.gitconfig ~/.gitconfig
ln -sf $CONFPATH/.gitignore_global ~/.gitignore_global
ln -sf $CONFPATH/.tigrc ~/.tigrc
ln -sf $CONFPATH/.tmux.conf ~/.tmux.conf
ln -sf $CONFPATH/.ignore ~/.ignore
ln -sf $CONFPATH/.ignore ~/.agignore
ln -sf $CONFPATH/.alacritty.yml ~/.alacritty.yml
ln -sf $CONFPATH/.editorconfig ~/.editorconfig
ln -sf $CONFPATH/.zshrc ~/.zshrc
ln -sf $CONFPATH/.zprofile ~/.zprofile
ln -sf $CONFPATH/asdf/.tool-versions ~/.tool-versions
ln -sf $CONFPATH/peco/config.json $HOME/.config/peco/config.json

# macOS
mkdir -p ~/Library/Application\ Support/Hyper
# ln -sf $CONFPATH/.hyper.js ~/Library/Application\ Support/Hyper/.hyper.js
ln -sf $CONFPATH/.hyper.js ~/.hyper.js # this is deprecated

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
mkdir -p ~/.vim/undo

mkdir -p ~/.cache/shell

echo "* asdf"
# https://asdf-vm.com/guide/getting-started.html#_2-download-asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin-add deno https://github.com/asdf-community/asdf-deno.git
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git

echo "* deno"
mkdir ~/.zsh/completion # create a folder to save your completions. it can be anywhere
deno completions zsh > ~/.zsh/completion/_deno

echo "* ruby"
ln -sf $CONFPATH/default_gems ~/.default-gems

# echo "* link diff-highlight"
# sudo ln -sf `brew --prefix git`/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight

echo "* go"
go install golang.org/x/tools/cmd/goimports@latest

echo "* gh"
gh alias set --shell prcreate 'gh pr view -w || gh pr create -w'

