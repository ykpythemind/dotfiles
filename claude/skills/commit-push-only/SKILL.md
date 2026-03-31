---
name: commit-push-only
description: Commit and push to the current branch (no PR creation)
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git push:*), Bash(git commit:*)
---

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Current branch: !`git branch --show-current`

## Your task

Based on the above changes:

1. Create commits with appropriate messages for each change. message should be in Japanese.
2. Push the current branch to origin. Even if the current branch is main or master, push directly.
3. You have the capability to call multiple tools in a single response. You MUST do all of the above in a single message. Do not use any other tools or do anything else. Do not send any other text or messages besides these tool calls.
