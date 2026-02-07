#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract current directory from JSON
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')

# Get current directory name (default for non-git)
dir_name=$(basename "$current_dir")
worktree_info=""

# Check if we're in a git repository
if git -C "$current_dir" rev-parse --git-dir > /dev/null 2>&1; then
  # Try to get remote repository name
  remote_url=$(git -C "$current_dir" remote get-url origin 2>/dev/null)
  if [ -n "$remote_url" ]; then
    # Extract repo name from URL (strip .git suffix, take last path segment)
    repo_name=$(basename "$remote_url" .git)
    dir_name="$repo_name"
  fi

  # Detect git worktree
  git_dir=$(git -C "$current_dir" rev-parse --git-dir 2>/dev/null)
  git_common_dir=$(git -C "$current_dir" rev-parse --git-common-dir 2>/dev/null)
  if [ "$git_dir" != "$git_common_dir" ]; then
    wt_name=$(basename "$current_dir")
    worktree_info=$(printf " \033[2m\033[33m[wt:%s]\033[0m" "$wt_name")
  fi

  # Get current branch name
  branch=$(git -C "$current_dir" branch --show-current 2>/dev/null)

  if [ -z "$branch" ]; then
    branch=$(git -C "$current_dir" rev-parse --short HEAD 2>/dev/null)
    git_info=$(printf "\033[2m on \033[0m\033[2m\033[33m➜\033[0m\033[2m $branch\033[0m")
  else
    git_info=$(printf "\033[2m on \033[0m\033[2m\033[35m$branch\033[0m")
  fi
else
  git_info=""
fi

# Context window usage
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
if [ "$PCT" -ge 90 ]; then
  ctx_color="\033[31m"  # red
elif [ "$PCT" -ge 70 ]; then
  ctx_color="\033[33m"  # yellow
else
  ctx_color="\033[2m"   # dim
fi

# Output format: directory [git info] | context %
printf "\033[2m\033[36m$dir_name\033[0m$worktree_info$git_info \033[2m│\033[0m ${ctx_color}${PCT}%%\033[0m"
