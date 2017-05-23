#
#  .zshrc
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

################################################

# alias
alias be='bundle exec'

################################################

export TERM=xterm-256color

HISTFILE=${HOME}/.zsh_history
HISTSIZE=100
SAVEHIST=1000
setopt hist_ignore_dups
setopt extended_history

# キーバインドをemacsモードで使用
bindkey -e

# Tabキーでの自動補完を有効にする
autoload -Uz compinit; compinit

# cdした先のディレクトリをスタック
setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space

# tab で補完候補を出した後選択できる
zstyle ':completion:*:default' menu select=1

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Ctrl + R で コマンド履歴をpecoで
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection
