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
sudo vim /etc/shells # which fishでのpathを追加
chsh -s $(which fish)
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

拡張 `Sync` をインストールし、GitHub連携で設定を同期させる

**Vim拡張でキーリピートを利くようにする設定が必要**
https://github.com/VSCodeVim/Vim#mac

## 他

- FireFox Developer Edition
- Chrome
- 1password
- Xcode
- Amphetamine
- Dash - https://kapeli.com/dash
