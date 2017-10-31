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
alias gs='git status'
alias rails='bin/rails'
alias rake='bin/rake'
alias rspec='bin/rspec'
#alias rg='rg --colors "match:none" --colors "match:bg:magenta"'

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

# checkout git branch
gco() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# checkout git branch (including remote branches)
gcor() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# gshow - git commit browser
gshow() {
  git log --graph --color=always \
      --abbrev-commit --date=format-local:'%Y/%m/%d %H:%M:%S' \
      --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
  --bind "ctrl-y:accept,enter:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}


# fcd - cd to selected directory, and preview
fcd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m --preview "ls -a {}" --height 100%) &&
  cd "$dir"
}

# MacVimへのパス
case "$(uname)" in
    Darwin) # Mac
        if [[ -d /Applications/MacVim.app ]]; then
          # export PATH=/Applications/MacVim.app/Contents/bin:$PATH
        fi
        ;;
    *) ;;
esac

