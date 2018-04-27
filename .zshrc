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
if which rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi

if [ -d ${HOME}/node_modules/.bin ]; then
    export PATH="$HOME/node_modules/.bin:$PATH"
fi

if which direnv > /dev/null; then
  eval "$(direnv hook zsh)"
fi

# z
. `brew --prefix`/etc/profile.d/z.sh

if [ `uname` = "Linux" ]; then
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
  export XDG_DATA_DIRS="/home/linuxbrew/.linuxbrew/share:$XDG_DATA_DIRS"
fi

if [ `uname` = "Darwin" ]; then
  if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi
  openxcode () {
    ruby "$HOME/dotfiles/openxcode.rb"
  }
fi


# docker

switch-machine () {
  eval $(docker-machine env $1)
}
unset-machine () {
  eval $(docker-machine env --unset)
}
alias active-machine='docker-machine active'

alias docker-m='docker-machine'
alias docker-c='docker-compose'
alias docker-clean-images='docker rmi $(docker images -a --filter=dangling=true -q)'
alias docker-clean-containers='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'

# go

export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$PATH"

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
alias gcom='git checkout master'
alias grebase='git rebase -i origin/master'
#alias rg='rg --colors "match:none" --colors "match:bg:magenta"'
alias atomb='atom-beta'

export TERM=xterm-256color

HISTFILE=${HOME}/.zsh_history
HISTSIZE=2000
SAVEHIST=50000
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

# ignore
function gitignore() { curl -L -s "https://www.gitignore.io/api/$@" ;}

function pushupstream() {
  git push -u origin `git branch | grep \* | cut -d ' ' -f2`
}

function rubyserver() {
  ruby -run -e httpd -- --port=${1:-5000} .
}

function localhost() {
  open http://localhost:${1:-3000}
}


# source zsh-key-bindings
source "${HOME}/dotfiles/key-bindings.zsh"
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--reverse --border'

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

# move to ghq dir
function ghq-fzf() {
  local selected_dir=$(ghq list | fzf --query="$LBUFFER")

  if [ -n "$selected_dir" ]; then
    BUFFER="cd $(ghq root)/${selected_dir}"
    zle accept-line
  fi

  zle reset-prompt
}

zle -N ghq-fzf
bindkey "^G" ghq-fzf


autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 200
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true

function fzf-cdr() {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | fzf)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle reset-prompt
}
zle -N fzf-cdr
bindkey '^[' fzf-cdr


