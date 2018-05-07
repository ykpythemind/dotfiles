
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
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisherman
fisher fzf decors/fish-ghq z ykpythemind/fish_fzf_z
```


## init.sh
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
