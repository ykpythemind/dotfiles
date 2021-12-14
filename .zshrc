# Clone zcomet if necessary
if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi
source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

zcomet load "MichaelAquilina/zsh-auto-notify"
zcomet load "zsh-users/zsh-autosuggestions"
zcomet load "zsh-users/zsh-completions"
zcomet load "sindresorhus/pure"
zcomet compinit

# pure
autoload -U promptinit; promptinit
prompt pure
zstyle ':prompt:pure:prompt:error' color yellow

eval "$(direnv hook zsh)"
stty eof undef

. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)

autoload -Uz compinit; compinit -i
# tabの補完候補から選択
zstyle ':completion:*:default' menu select=1

setopt rm_star_wait

setopt auto_pushd
setopt pushd_ignore_dups

HISTFILE=${HOME}/.zsh_history
HISTSIZE=1000000
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
export PATH="$HOME/go/bin:$PATH" # go installでデフォで入ってくる
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export FZF_DEFAULT_OPTS="--reverse"
export GHQ_SELECTOR="fzf"

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export RIPGREP_CONFIG_PATH=$HOME/dotfiles/ripgrep_rc
export ASDF_CONFIG_FILE=$HOME/dotfiles/asdf/.asdfrc

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

# cdr

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true

# alias
alias dc='docker-compose'
alias ga='git_fuzzy_stage_files; git status --short'
alias la='ls -laG'
alias vim='nvim'
alias docker-clean-images='docker rmi $(docker images -a --filter=dangling=true -q)'
alias docker-clean-containers='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'


#
# function
#

function gcom() {
  local ret
  git branch | grep --silent "main\$"
  ret=$?
  if [ $ret = 0 ]; then
    git switch main
  else
    git switch master
  fi
}

function push() {
  local result st a
  result=$(git push 2>&1 -u origin `git branch | grep \* | cut -d ' ' -f2`)
  st=$?

  if [ $st = 0 ]; then
    a=$(echo "$result" | grep 'Create a pull request for')
    if [ -n "$a" ]; then
      git brws --pr
    fi
  else
    echo 'git push failed.'
  fi

  echo $result
  return $st
}

# checkout git branch
gco() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | peco) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# checkout git branch (including remote branches)
gcor() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" | peco) &&
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

function fzf-process() {
  ps -ef | sed 1d | fzf ${FZF_DEFAULT_OPTS} -m | awk '{print $2}'
}

# move to ghq dir
function inc-ghq() {
  local selected_dir=$(ghq list | peco --query="$LBUFFER")

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

function peco-history-selection() {
    BUFFER=`history -n -r 1 | peco --query "$LBUFFER"`
    CURSOR=$#BUFFER
    zle reset-prompt
}
# zle -N inc-history
# bindkey '^R' inc-history
zle -N peco-history-selection
bindkey '^R' peco-history-selection

function inc-cdr() {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}
zle -N inc-cdr
bindkey '^Y' inc-cdr

autoload -U edit-command-line
zle -N edit-command-line
bindkey -e '^O' edit-command-line
