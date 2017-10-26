
# dotfiles


## install prezto
https://github.com/sorin-ionescu/prezto



0. install Zsh with Homebrew ( brew install zsh)

1. Launch Zsh:

      `zsh`

2. Clone the repository:

      `git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"`

3. Skip(alias)

4. Set Zsh as your default shell:

      `chsh -s usr/local/bin/zsh`



## alias
```console
git clone https://github.com/ykpythemind/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh ./init.sh
```

## prezto update
```console
zprezto-update
```

### vimplug

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

```
vim
:PlugInstall
```

