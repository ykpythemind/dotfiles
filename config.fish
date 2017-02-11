set -x PATH /usr/local/bin /usr/sbin $PATH
set -x PATH "/usr/local/sbin" $PATH

set -x PATH $HOME/.pyenv/bin $PATH
set -x PATH $HOME/.rbenv/bin $PATH
set -x PATH $HOME/.nodenv/bin $PATH

rbenv init - | source
nodenv init - | source
pyenv init - | source

eval (direnv hook fish)

set -U GHQ_SELECTOR fzf
set -x FZF_DEFAULT_OPTS '--reverse'

if type -q nvim
  set -x EDITOR nvim
  set -x VISUAL nvim
else
  set -x EDITOR vim
  set -x VISUAL vim
end

set -x PAGER less
set -x LESS '--hilite-search -i -M --RAW-CONTROL-CHARS --no-init --shift 4 --quit-if-one-screen'
set -x LESSCHARSET utf-8

# go

set GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH

# alias

alias vim='nvim'
alias be='bundle exec'
alias g='git'

# docker

alias docker-clean-images='docker rmi (docker images -a --filter=dangling=true -q)'
alias docker-clean-containers='docker rm (docker ps --filter=status=exited --filter=status=created -q)'

# java
set -g fish_user_paths "/usr/local/opt/openjdk/bin" $fish_user_paths

# utils

function pushupstream
  git push -u origin (git branch | grep \* | cut -d ' ' -f2)
end

function gco -d "Fuzzy-find and checkout a branch"
  git branch | grep -v HEAD | string trim | fzf | xargs git checkout
end
alias gsw='gco'

function gcom -d "checkout master or main"
  git branch | grep "main\$"
  if test $status -eq 0
    git switch main
  else
    git switch master
  end
end

function gpr -d "Open PR on GitHub"
  gh pr list | tail -n +1 | fzf | awk '{ print $1 }' | read num
  if [ $num ]
    gh pr view $num --web
  end
end

function gcor -d "Fuzzy-find and checkout a branch (include remote)"
   git branch -a | fzf | tr -d ' ' | read branch
   echo $branch
   if [ $branch ]
       set -l b (echo $branch | string replace '^remotes/.+?/' '' -r)
       if test $status -eq 0
           git checkout -b $b $branch
       else
           git checkout $branch
       end
   end
   commandline -f repaint
end
alias gswr='gcor'

function __fish_fzf_history
  history --save
  history --merge

  history | peco --initial-filter=Fuzzy | perl -pe 'chomp if eof' | read -lz result
  and commandline -- $result
  commandline -f repaint
end

function __fish_fzf_z -d 'z + fzf'
  set -l query (commandline)

  z -l | fzf | awk '{ print $2 }' | read recent
  if [ $recent ]
      cd $recent
      commandline -r ''
      commandline -f repaint
  end
end

function __fzf_ghq
  ghq list --full-path | fzf | read result
  if [ "$result" ]
    cd "$result"
    commandline -f repaint
  end
end

bind \c] '__fish_fzf_z' # ctrl + ]
bind \cr '__fish_fzf_history' # ctrl + r
bind \cg '__fzf_ghq' # ctrl + g

function fish_title
    echo (basename (pwd)) '-' $_
end

if test -e ~/.git-brws-token
  set -l token (cat ~/.git-brws-token)
  set -x GIT_BRWS_GITHUB_TOKEN $token
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f ~/google-cloud-sdk/path.fish.inc ];
  source ~/google-cloud-sdk/path.fish.inc
end

# https://github.com/pure-fish/pure
set --universal pure_symbol_prompt '$'
