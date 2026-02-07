---
allowed-tools: Bash(git checkout --branch:*), Bash(git add:*), Bash(git status:*), Bash(git push:*), Bash(git commit:*), Bash(gh pr checks:*), Bash(gr run view:*)
description: Check the status of a pull request and try to fix
---

# Your task

- Check the status of the pull request
- If the pull request is not passing checks, try to fix the issues
- If the pull request is passing checks, open the pull request in the browser

# Fixing issues

To fix issues, you can use the following tools:

- `gh pr checks` to check the status of the pull request
- `gr run view` to view the details of a run

直し方が不明な場合はユーザーに積極的に質問してください。テストの失敗量が多すぎる場合は報告してください。

# Opening the pull request in the browser

To open the pull request in the browser, you can use the following tool:

- `gh pr view` to open the pull request in the browser
