fpath+=$HOME/.zsh/pure

autoload -U promptinit; promptinit
prompt pure
zstyle ':prompt:pure:prompt:error' color yellow

autoload -Uz compinit; compinit -i
# tabの補完候補から選択
zstyle ':completion:*:default' menu select=1

eval "$(direnv hook zsh)"
stty eof undef

if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions/src $fpath)
fi

if [ -e /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [ -e ~/.zsh/completion ]; then
    fpath=(~/.zsh/completion $fpath)
fi

alias la='ls -laG'
alias vim='nvim'

alias docker-clean-images='docker rmi $(docker images -a --filter=dangling=true -q)'
alias docker-clean-containers='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'

setopt auto_pushd
setopt pushd_ignore_dups

HISTFILE=${HOME}/.zsh_history
HISTSIZE=10000
SAVEHIST=1000000
setopt hist_ignore_dups
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history

bindkey -e

unsetopt EXTENDED_GLOB

#
# export
#

export PATH="$HOME/.rbenv/bin:$PATH"
export FZF_DEFAULT_OPTS="--reverse"
export GHQ_SELECTOR="fzf"

export RIPGREP_CONFIG_PATH=$HOME/dotfiles/ripgrep_rc

if [ -e ${HOME}/.git-token ]; then
  export GITHUB_TOKEN=$(cat "${HOME}/.git-token")
fi

if which nvim > /dev/null; then
  export EDITOR=nvim
  export VISUAL=nvim
else
  export EDITOR=vim
  export VISUAL=vim
fi

export PAGER=less
export LESS='--hilite-search -i -M --RAW-CONTROL-CHARS --no-init --shift 4 --quit-if-one-screen'
export LESSCHARSET=utf-8

if which rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi

if which nodenv > /dev/null; then
  eval "$(nodenv init -)"
fi

# cdr

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true

#
# function
#

function gcom() {
  local ret
  git branch | grep "main\$"
  ret=$?
  if [ $ret = 0 ]; then
    git switch main
  else
    git switch master
  fi
}

function pushupstream() {
  git push -u origin `git branch | grep \* | cut -d ' ' -f2`
}

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
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
alias gsw='gco'
alias gswr='gcor'

gpr() {
  local pr arg
  pr=$(gh pr list | tail -n +1 | fzf | awk '{ print $1 }')
  if [ -n "$pr" ]; then
    if [ $1 = "checkout" ]; then
      gh pr checkout $pr
    else
      gh pr view $pr --web
    fi
  fi
}

# move to ghq dir
function inc-ghq() {
  local selected_dir=$(ghq list | fzf --query="$LBUFFER")

  if [ -n "$selected_dir" ]; then
    BUFFER="cd $(ghq root)/${selected_dir}"
    zle accept-line
  fi

  zle reset-prompt
}

zle -N inc-ghq
bindkey "^G" inc-ghq

# CTRL-R - Paste the selected command from history into the command line
inc-history() {
  BUFFER=$(history -n -r 1 | fzf -d --reverse --no-height --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N inc-history
bindkey '^R' inc-history

function inc-cdr() {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | fzf)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}
zle -N inc-cdr
bindkey '^H' inc-cdr
