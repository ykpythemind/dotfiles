#
#  .zshrc
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#
# path
#

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

#
# alias
#

alias be='bundle exec'
alias psg='ps aux|grep'
alias ..='cd ./..'
alias la='ls -laG'
alias l1='ls -1G'
alias -g B='`git branch | peco | sed -e "s/^\*[ ]*//g"`'

export TERM=xterm-256color

HISTFILE=${HOME}/.zsh_history
HISTSIZE=500
SAVEHIST=10000
setopt hist_ignore_dups
setopt extended_history

bindkey -e

# tabキーで補完
autoload -Uz compinit; compinit

# tabの補完候補から選択
zstyle ':completion:*:default' menu select=1

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# directory stack
DIRSTACKSIZE=30
setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space

unsetopt extended_glob

# Ctrl+R -> pecoでコマンド履歴
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection
### 

case "$(uname)" in
    Darwin) # OSがMac
        if [[ -d /Applications/MacVim.app ]]; then # MacVimが存在
          alias mvim=/Applications/MacVim.app/Contents/bin/mvim
        fi
        ;;
    *) ;;
esac
