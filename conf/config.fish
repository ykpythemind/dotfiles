set -x PATH /usr/local/bin /usr/sbin $PATH
set -x PATH $HOME/.rbenv/bin $PATH
set -Ux fish_user_paths $HOME/.nodenv/bin $fish_user_paths
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

rbenv init - | source
nodenv init - | source

eval (direnv hook fish)

set -U GHQ_SELECTOR peco

function history-merge --on-event fish_preexec
  history --save
  history --merge
end

set -x EDITOR vim
set -x VISUAL vim
set -x PAGER less
set -x LESS '-g -i -M -R -S -w -z-4'

# alias

alias be='bundle exec'
alias psg='ps aux|grep'
alias gcom='git checkout master'
alias grebase='git rebase -i origin/master'
alias g='git'

# docker

alias docker-clean-images='docker rmi (docker images -a --filter=dangling=true -q)'
alias docker-clean-containers='docker rm (docker ps --filter=status=exited --filter=status=created -q)'

# go
set GOPATH $HOME/go
set PATH $GOPATH/bin $PATH

# utils

function pushupstream
  git push -u origin (git branch | grep \* | cut -d ' ' -f2)
end

function git-delete-merged
  git branch --merged | egrep -v '\*|develop|master'  | xargs git branch -d
end

function rubyserver
  ruby -run -e httpd -- --port=$argv .
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
  fish_active_machine
end

function fish_active_machine
  if test -n "$DOCKER_MACHINE_NAME"
    printf "$DOCKER_MACHINE_NAME"
  end
end

function gco -d "Fuzzy-find and checkout a branch"
  git branch | grep -v HEAD | string trim | peco | xargs git checkout
end

function gcor -d "Fuzzy-find and checkout a branch (include remote)"
   git branch -a | peco | tr -d ' ' | read branch
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

function fssh -d "Fuzzy-find ssh host and ssh into it"
  grep -E '^(H|h)ost' ~/.ssh/config | cut -d ' ' -f 2 | peco | xargs -o ssh
end

function __fish_peco_history
  history --save
  history --merge

  history | peco | perl -pe 'chomp if eof' | read -lz result
  and commandline -- $result
  commandline -f repaint
end

function __fish_peco_z -d 'z + peco'
  set -l query (commandline)

  z -l | peco | awk '{ print $2 }' | read recent
  if [ $recent ]
      cd $recent
      commandline -r ''
      commandline -f repaint
  end
end

bind \c] '__fish_peco_z' # ctrl + ]
bind \cr '__fish_peco_history' # ctrl + r
