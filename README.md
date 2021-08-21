# dotfiles

```
git clone https://github.com/ykpythemind/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh ./init.sh
```

homebrew を入れる

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
cd ~/dotfiles
brew bundle
```

## zsh

### Setup

Mac OS

```
sudo vim /etc/shells # `brew --prefix zsh` を追加
chsh -s /usr/local/bin/zsh # brew --prefix zshの結果
```

plugin インストールしたら

```
  rm -f ~/.zcompdump; compinit
```

## vim

- vimplug をインストール (init.sh でインストール済み)

in vim

```
:PlugInstall
```


## 他

- https://scrapbox.io/ykpythemind/Mac%E3%81%AB%E5%85%A5%E3%82%8C%E3%81%A6%E3%82%8B%E3%82%A2%E3%83%97%E3%83%AA
- ~/.git-token に GitHub private token を置くと git brws コマンドで使える
