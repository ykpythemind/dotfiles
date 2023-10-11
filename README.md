# dotfiles

```
git clone git@github.com:ykpythemind/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

homebrew を入れる

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
cd ~/dotfiles
brew bundle
```

init script

```
sh ./init.sh
```

## zsh

### Setup

Mac OS

```
sudo vim /etc/shells # `brew --prefix zsh` の結果を追加
chsh -s `brew --prefix zsh`
```

## neovim

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

:PlugInstall
```

## 他

- Mac app
  - https://scrapbox.io/ykpythemind/Mac%E3%81%AB%E5%85%A5%E3%82%8C%E3%81%A6%E3%82%8B%E3%82%A2%E3%83%97%E3%83%AA
- font
  - nerd font
    - brew tap homebrew/cask-fonts
    - brew install --cask font-hack-nerd-font
  - SF Mono https://developer.apple.com/fonts/
  - Cica https://github.com/miiton/Cica
