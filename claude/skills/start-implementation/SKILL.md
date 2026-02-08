---
name: start-implementation
description: Start implementation based on the existing plan
allowed-tools: Bash(find *), Skill
disable-model-invocation: true
---

# Start implementation based on the existing plan $ARGUMENTS

## Your task

- Start implementation from an existing plan file.
- Plan File Path: settings.jsonの `plansDirectory` を参照する。設定がない場合は `{REPOSITORY_ROOT}/docs/plans` をデフォルトとして使う
- File name: `{YYYY-MM-DD}-{plan-name}.md`

if plan file location is ambiguous, ask the user to specify the plan.
