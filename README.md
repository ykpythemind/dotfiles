
# dotfiles


## install prezto
https://github.com/sorin-ionescu/prezto



1. install Zsh 

  - brew install zsh (Mac OS)
  - sudo apt-get update && sudo apt-get install zsh (Ubuntu)

2. Clone the repository:

      `git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"`

3. Alias

      `sh ~/dotfiles/init.sh`

4. Set Zsh as your default shell:

      `chsh -s $(which zsh)`


## alias
```console
git clone https://github.com/ykpythemind/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh ./init.sh
sh ./completion.sh
```

## prezto update
```console
zprezto-update
```

### vimplug

for vim
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

for nvim
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.config/nvim/
ln -s ~/.vim ~/.config/nvim/
ln -s ~/.vimrc ~/.config/nvim/init.vim
```


in vim
```
:PlugInstall
```

