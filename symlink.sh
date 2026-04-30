#!/bin/sh

CONFPATH="$PWD"

echo "* symlink"
mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.config/direnv
mkdir -p $HOME/.config/ghostty
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
ln -sf $CONFPATH/.ghostty ~/.config/ghostty/config
ln -sf $CONFPATH/claude/settings.json ~/.claude/settings.json
ln -sf $CONFPATH/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sfn $CONFPATH/claude/commands ~/.claude/commands

# skillsはディレクトリごとではなく ykpy- prefix付きで個別にsymlinkする
# (dotfiles管理外のskillと共存させ、自分管理のものを明示するため)
if [ -L "$HOME/.claude/skills" ]; then
  rm "$HOME/.claude/skills"
fi
mkdir -p "$HOME/.claude/skills"

# dotfiles配下を指すsymlinkを一旦掃除する
# - 旧prefixなしsymlink (移行用)
# - dotfilesから削除されたskillの ykpy-* symlink (壊れリンク含む)
for link in "$HOME"/.claude/skills/*; do
  [ -L "$link" ] || continue
  target=$(readlink "$link")
  case "$target" in
    "$CONFPATH/claude/skills/"*) rm "$link" ;;
  esac
done

# dotfiles側の各skillを ykpy-<name> で張り直す
for skill in "$CONFPATH"/claude/skills/*/; do
  name=$(basename "$skill")
  ln -sfn "$skill" "$HOME/.claude/skills/ykpy-$name"
done
ln -sf $CONFPATH/claude/statusline-command.sh ~/.claude/statusline-command.sh
