#!/bin/sh

CONFPATH="$PWD"

echo "* symlink"
mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.config/direnv

ln -sf $CONFPATH/.gitconfig ~/.gitconfig
ln -sf $CONFPATH/.gitignore_global ~/.gitignore_global
ln -sf $CONFPATH/.tmux.conf ~/.tmux.conf
ln -sf $CONFPATH/.ignore ~/.ignore
ln -sf $CONFPATH/.ignore ~/.agignore
ln -sf $CONFPATH/.alacritty.yml ~/.alacritty.yml
ln -sf $CONFPATH/.zshrc ~/.zshrc
ln -sf $CONFPATH/.zprofile ~/.zprofile
ln -sf $CONFPATH/.vimrc ~/.vimrc
ln -sf $CONFPATH/.vimrc ~/.config/nvim/init.vim
ln -sf $CONFPATH/direnvrc $HOME/.config/direnv/direnvrc
ln -sf $CONFPATH/asdf/.tool-versions ~/.tool-versions
ln -sf $CONFPATH/karabiner.json $HOME/.config/karabiner/karabiner.json
ln -sf $CONFPATH/.hammerspoon/init.lua $HOME/.hammerspoon/init.lua

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

echo "* neovim"
#mkdir -p ~/.config/nvim
#ln -sf $(pwd)/.config/nvim/init.lua $HOME/.config/nvim/init.lua
#mkdir -p $HOME/.config/nvim/lua
#find .config -type f | xargs -I% ln -sf $(pwd)/% $HOME/%

mkdir -p ~/.vim/undo
mkdir -p ~/.cache/shell

echo "* asdf"
# https://asdf-vm.com/guide/getting-started.html#_2-download-asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin-add deno https://github.com/asdf-community/asdf-deno.git
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git

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
gh extension install seachicken/gh-poi
