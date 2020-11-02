# dotfiles

## Install dependencies

```
git clone https://github.com/ykpythemind/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh ./init.sh
```

homebrewを入れる

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

```
cd ~/dotfiles
ruby dep-install.rb
```

## Setup fish shell

Mac OS

```
sudo vim /etc/shells # /usr/local/bin/fish を追加
chsh -s /usr/local/bin/fish
```

## ruby

- rbenv - https://github.com/rbenv/rbenv
  - `git clone https://github.com/rbenv/rbenv.git ~/.rbenv`
- ruby-build - https://github.com/rbenv/ruby-build
  - `mkdir -p "$(rbenv root)"/plugins`
  - `git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build`

共にgit cloneでインストール

## vim

- vimplugをインストール (init.shでインストール済み)

in vim
```
:PlugInstall
```

## vscode

**Vim拡張でキーリピートを利くようにする設定が必要**
https://github.com/VSCodeVim/Vim#mac

## 他

- https://scrapbox.io/ykpythemind/Mac%E3%81%AB%E5%85%A5%E3%82%8C%E3%81%A6%E3%82%8B%E3%82%A2%E3%83%97%E3%83%AA
- ~/.git-brws-token にGitHub private tokenを置くとgit brwsコマンドで使える
