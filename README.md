
# dotfiles


## install fish shell

```
brew install fish
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisherman
fisher fzf
fisher decors/fish-ghq
fisher z
fisher ykpythemind/fish_fzf_z
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
