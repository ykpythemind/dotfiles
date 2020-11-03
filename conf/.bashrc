PS1="\u: \$(basename \"$PWD\")> "

eval "$(direnv hook bash)"

# peco-history
# thx http://www.fisproject.jp/2015/01/peco/
function peco-history
{
    declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
    # for OSX
    if [ `uname` = "Darwin" ]; then
        ${READLINE_LINE}
    fi
}
bind -x '"\C-r": peco-history'

if which direnv &> /dev/null; then
  eval "$(direnv hook bash)"
fi

alias la='ls -la'

function peco-ghq {
  local selected_file=$(ghq list --full-path | peco --query "$LBUFFER")
  if [ -n "$selected_file" ]; then
    if [ -t 1 ]; then
      echo ${selected_file}
      cd ${selected_file}
    fi
  fi
}
bind -x '"\C-g": peco-ghq'

# checkout git branch
function gco {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | peco) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# checkout git branch (including remote branches)
function gcor {
  git branch -a --sort=-authordate | cut -b 3- | perl -pe 's#^remotes/origin/###' | perl -nlE 'say if !$c{$_}++' | grep -v -- "->" | peco | xargs git checkout
}
