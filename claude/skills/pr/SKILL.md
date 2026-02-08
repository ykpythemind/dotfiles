---
name: pr
description: Manage pull request. Automatically check the status of the pull request and try to fix issues.
allowed-tools: Bash(git checkout --branch:*), Bash(git add:*), Bash(git status:*), Bash(git push:*), Bash(git commit:*), Bash(gh pr checks:*), Bash(gh pr view:*), Bash(gh pr list:*), Bash(gr run view:*), Skill(commit-push-pr)
---

# Your task

- If no pull request exists for the branch, use `commit-push-pr` skill to create a pull request
- Check the status of the pull request
- If the pull request is not passing checks, try to fix the issues
- If the pull request is passing checks, open the pull request in the browser
- Resolve review comments

# Fixing issues

To fix issues, you can use the following tools:

- `gh pr checks` to check the status of the pull request
- `gr run view` to view the details of a run

直し方が不明な場合はユーザーに積極的に質問してください。テストの失敗量が多すぎる場合は報告してください。

# Resolve Review Comments

レビューコメントを見て、もしそれが今回のPRに対して重要な指摘だと判断できたら、planファイルにその旨を追記して、修正を試みてください。重要な指摘とは、仕様の変更や致命的なバグの可能性についての言及になります。
判断が難しい場合はユーザーに積極的に質問してください。

# Opening the pull request in the browser

To open the pull request in the browser, you can use the following tool:

- `gh pr view` to open the pull request in the browser
