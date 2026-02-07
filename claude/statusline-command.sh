#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract current directory from JSON
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')

# Get current directory name
dir_name=$(basename "$current_dir")

# Check if we're in a git repository and get branch info
if git -C "$current_dir" rev-parse --git-dir > /dev/null 2>&1; then
  # Get current branch name
  branch=$(git -C "$current_dir" branch --show-current 2>/dev/null)
  
  if [ -z "$branch" ]; then
    # Detached HEAD state - show short commit hash
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
printf "\033[2m\033[36m$dir_name\033[0m$git_info \033[2m│\033[0m ${ctx_color}${PCT}%%\033[0m"
