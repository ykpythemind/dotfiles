set PATH /usr/local/bin /usr/sbin $PATH
set -x PATH $HOME/.rbenv/bin $PATH

rbenv init - | source

if test -x "direnv"
  eval (direnv hook fish)
end

switch (uname)
case Linux
  set PATH $HOME/linuxbrew/.linuxbrew/bin $PATH
  set XDG_DATA_DIRS $HOME/linuxbrew/.linuxbrew/share $XDG_DATA_DIRS
case Darwin
  function openxcode
    ruby "$HOME/dotfiles/openxcode.rb"
  end
end


# Editors

set EDITOR vim
set VISUAL vim
set PAGER less
set LESS '-g -i -M -R -S -w -z-4'


# fzf settings
set FZF_DEFAULT_OPTS '--reverse --border'
set FZF_REVERSE_ISEARCH_OPTS "--height 50%"


# alias

alias be='bundle exec'
alias psg='ps aux|grep'
alias l1='ls -1G'
# alias B='`git branch | fzf | sed -e "s/^\*[ ]*//g"`'
alias gs='git status'
alias rails='bin/rails'
alias rake='bin/rake'
alias gcom='git checkout master'
alias grebase='git rebase -i origin/master'
alias atomb='atom-beta'


# docker

function switch-machine
  eval (docker-machine env $argv)
end

function unset-machine
  eval (docker-machine env --unset)
end

alias active-machine='docker-machine active'

alias docker-m='docker-machine'
alias docker-c='docker-compose'
alias docker-clean-images='docker rmi (docker images -a --filter=dangling=true -q)'
alias docker-clean-containers='docker rm (docker ps --filter=status=exited --filter=status=created -q)'


# go
set GOPATH $HOME/go
set PATH $GOPATH/bin $PATH


# utils

function pushupstream
  git push -u origin (git branch | grep \* | cut -d ' ' -f2)
end

function rubyserver
  # ruby -run -e httpd -- --port=${1:-5000} .
end

function localhost
  # open http://localhost:${1:-3000}
end

# fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

function fish_right_prompt
  printf '%s' (__fish_git_prompt)
end


function fzf_z
  set -l query (commandline)

  if test -n $query
    set peco_flags --query "$query"
  end

  z -l | fzf | awk '{ print $2 }' | read recent
  if [ $recent ]
      cd $recent
      commandline -r ''
      commandline -f repaint
  end
end

bind \x1b fzf_z # Ctrl-[

function gco -d "Fuzzy-find and checkout a branch"
  git branch | grep -v HEAD | string trim | fzf | xargs git checkout
end

function gcor -d "Fuzzy-find and checkout a branch (include remote)"
  git branch --all | grep -v HEAD | string trim | fzf | xargs git checkout
end

function fssh -d "Fuzzy-find ssh host and ssh into it"
  ag '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2 | fzf | xargs -o ssh
end

