
# dotfiles

## install fish shell

Mac OS

```
brew install fish
sudo vim /etc/shells # specify fish path (e.g. /usr/local/bin/fish)
chsh -s $(which fish)
```

restart terminal

```
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fisher add franciscolourenco/done decors/fish-ghq jethrokuan/z ykpythemind/fish_peco_z jethrokuan/fzf
```


## init

```console
git clone https://github.com/ykpythemind/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh ./init.sh
```

### vimplug

for vim
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

in vim
```
:PlugInstall
```
