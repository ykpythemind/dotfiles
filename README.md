
# dotfiles


## install prezto
https://github.com/sorin-ionescu/prezto


## alias
clone this repository first
```console
cd dotfiles
sh ./init.sh
```

## molokai
```console
mkdir -p ~/.vim/colors
cp molokai.vim ~/.vim/colors/
```


## prezto update
```console
cd ~/.zprezto
git pull && git submodule update --init --recursive
```

## filetype
```console
~/.vim/ftplugin/ruby.vim

set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set autoindent
```

