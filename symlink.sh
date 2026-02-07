#!/bin/sh

CONFPATH="$PWD"

echo "* symlink"
mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.config/direnv
mkdir -p $HOME/.claude

ln -sf $CONFPATH/.gitconfig ~/.gitconfig
ln -sf $CONFPATH/.gitignore_global ~/.gitignore_global
ln -sf $CONFPATH/.tmux.conf ~/.tmux.conf
ln -sf $CONFPATH/.ignore ~/.ignore
ln -sf $CONFPATH/.ignore ~/.agignore
ln -sf $CONFPATH/.zshrc ~/.zshrc
ln -sf $CONFPATH/.zprofile ~/.zprofile
ln -sf $CONFPATH/.vimrc ~/.vimrc
ln -sf $CONFPATH/.vimrc ~/.config/nvim/init.vim
ln -sf $CONFPATH/claude/settings.json ~/.claude/settings.json
ln -sfn $CONFPATH/claude/commands ~/.claude/commands
ln -sfn $CONFPATH/claude/skills ~/.claude/skills
