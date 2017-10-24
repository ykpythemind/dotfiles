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
alias l1='ls -1G'
alias -g B='`git branch | fzf | sed -e "s/^\*[ ]*//g"`'
alias -g H='$(git-hash)'

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

# git-hash
function git-hash(){
   git log --oneline --branches | fzf | awk '{print $1}'
 }
### 

# source zsh-key-bindings
source "${HOME}/dotfiles/key-bindings.zsh"
source "${HOME}/dotfiles/zsh-interactive-cd.plugin.zsh"
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

case "$(uname)" in
    Darwin) # Mac
        if [[ -d /Applications/MacVim.app ]]; then
          export PATH=/Applications/MacVim.app/Contents/bin:$PATH
        fi
        ;;
    *) ;;
esac
