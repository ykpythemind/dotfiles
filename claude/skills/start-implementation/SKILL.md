---
name: start-implementation
description: Start implementation based on the existing plan
allowed-tools: Bash(find *), Skill
disable-model-invocation: true
---

# Start implementation based on the existing plan $ARGUMENTS

## Your task

- Start from an existing plan
- Path: `{REPOSITORY_ROOT}/.claude/plans/`
- File name: `{YYYY-MM-DD}-{plan-name}.md`

if plan is ambiguous, ask the user to specify the plan.
