# dotfiles

## Install dependencies

```console
git clone https://github.com/ykpythemind/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh ./init.sh
```

homebrewを入れる

```console
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

```console
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

- rbenv https://github.com/rbenv/rbenv#basic-github-checkout
- ruby-build https://github.com/rbenv/ruby-build#readme
  - $ mkdir -p "$(rbenv root)"/plugins
  - $ git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

共にgit cloneでインストール

### vim

- vimplugをインストール (init.shでインストール済み)

in vim
```
:PlugInstall
```

### vscode

拡張 `Sync` をインストールし、GitHub連携で設定を同期させる

**Vim拡張でキーリピートを利くようにする設定が必要**
https://github.com/VSCodeVim/Vim#mac


### 他

- FireFox Developer Edition
- Chrome
- 1password
- XCode
- Amphetamine
