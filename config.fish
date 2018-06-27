set -x PATH /usr/local/bin /usr/sbin $PATH
set -x PATH $HOME/.rbenv/bin $PATH
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

rbenv init - | source

eval (direnv hook fish)

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

set -x EDITOR vim
set -x VISUAL vim
set -x PAGER less
set -x LESS '-g -i -M -R -S -w -z-4'


# fzf settings
set -x FZF_DEFAULT_OPTS '--reverse --border'
set -x FZF_REVERSE_ISEARCH_OPTS "--height 50%"
if which rg ^ /dev/null > /dev/null
  set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'
end

# alias

alias be='bundle exec'
alias psg='ps aux|grep'
alias l1='ls -1G'
alias gs='git status'
alias gcom='git checkout master'
alias grebase='git rebase -i origin/master'
alias atomb='atom-beta'
alias g='git'


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

function git-delete-merged
  git branch --merged | egrep -v '\*|develop|master'  | xargs git branch -d
end

function rubyserver
  ruby -run -e httpd -- --port=$argv .
end

function localhost
  open "http://localhost:$argv"
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

function history-merge --on-event fish_preexec
  history --save
  history --merge
end

function __original_reverse_isearch
  history-merge
  history -z | eval (__fzfcmd) --read0 --tiebreak=index --toggle-sort=ctrl-r $FZF_DEFAULT_OPTS $FZF_REVERSE_ISEARCH_OPTS -q '(commandline)' | perl -pe 'chomp if eof' | read -lz result
  and commandline -- $result
  commandline -f repaint
end

# override
function __fzf_reverse_isearch
  if which fish_uniq_history > /dev/null ^ /dev/null
    history-merge
    eval fish_uniq_history | fzf --tiebreak=index --toggle-sort=ctrl-r --reverse --height=40% | perl -pe 'chomp if eof' | read -lz result
    and commandline -- $result
    commandline -f repaint
  else
    __original_reverse_isearch
  end
end

function gco -d "Fuzzy-find and checkout a branch"
  git branch | grep -v HEAD | string trim | fzf | xargs git checkout
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

function fssh -d "Fuzzy-find ssh host and ssh into it"
  ag '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2 | fzf | xargs -o ssh
end

