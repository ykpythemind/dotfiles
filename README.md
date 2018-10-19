
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
fisher add fzf decors/fish-ghq z ykpythemind/fish_vi_binding_helper ykpythemind/fish_fzf_z done
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
